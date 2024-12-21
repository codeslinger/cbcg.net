#!/usr/bin/env bash
set -eo pipefail

D=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

source $D/.env

deploy() {
    aws cloudformation deploy \
        --region us-east-1 \
        --no-fail-on-empty-changeset \
        --stack-name "${CF_STACK}" \
        --template-file $D/infra.cftemplate.yml \
        --parameter-overrides \
            "DomainName=${DOMAIN_NAME}" \
            "HostedZoneId=${HOSTED_ZONE_ID}" \
            "HostedZoneName=${HOSTED_ZONE_NAME}"
}

sync_site() {
    aws s3 sync $D/_site/ "s3://${ORIGIN_BUCKET}" --delete --region us-east-1
}

case "$1" in
    deploy)
        deploy
        ;;
    sync)
        sync_site
        ;;
    *)
        >&2 echo "error: unrecognized command"
        exit 1
        ;;
esac
