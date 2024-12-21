all: build

s:
	npx @11ty/eleventy --serve

build:
	npx @11ty/eleventy

clean:
	rm -rf _site .cache

over: clean build

ss: clean s

setup:
	rm -rf node_modules
	npm install

deploy:
	./do deploy

sync:
	./do sync

.PHONY: all s clean over ss setup deploy sync
