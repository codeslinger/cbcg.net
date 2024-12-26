#!/usr/bin/env bash
set -eo pipefail

AWS="aws --region us-east-1"
D=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

source $D/.env

deploy() {
    $AWS cloudformation deploy \
        --no-fail-on-empty-changeset \
        --stack-name "${CF_STACK}" \
        --template-file $D/infra.cftemplate.yml \
        --parameter-overrides \
            "DomainName=${DOMAIN_NAME}" \
            "HostedZoneId=${HOSTED_ZONE_ID}" \
            "HostedZoneName=${HOSTED_ZONE_NAME}"
}

invalidate() {
    DIST_ID=$(
        $AWS cloudformation describe-stacks \
            --stack-name $CF_STACK \
            --output json | \
        jq -r '.Stacks[0].Outputs[] | select(.OutputKey == "CloudfrontDistribution") | .OutputValue'
    )
    echo "Found distribution ID $DIST_ID for stack $CF_STACK"
    INVALIDATION_ID=$(
        $AWS cloudfront create-invalidation \
            --distribution-id $DIST_ID \
            --paths "/*" \
            --output json | jq -r '.Invalidation.Id'
    )
    echo "Invalidation $INVALIDATION_ID for distribution $DIST_ID is underway..."
    FINISHED=0
    while [ $FINISHED -eq 0 ]; do
        sleep 3
        STATUS=$(
            $AWS cloudfront get-invalidation \
                --distribution-id $DIST_ID \
                --id $INVALIDATION_ID \
                --output json | jq -r '.Invalidation.Status'
        )
        case $STATUS in
            "Completed")
                FINISHED=1
                echo "Invalidation $INVALIDATION_ID complete"
                ;;
            *)
                echo "Invalidation $INVALIDATION_ID still pending ($STATUS)"
                ;;
        esac
    done
}

sync() {
    $AWS s3 sync $D/_site/ "s3://${ORIGIN_BUCKET}" --delete
}

case "$1" in
    deploy)
        deploy
        ;;
    invalidate)
        invalidate
        ;;
    sync)
        sync
        ;;
    *)
        >&2 echo "error: unrecognized command"
        exit 1
        ;;
esac
