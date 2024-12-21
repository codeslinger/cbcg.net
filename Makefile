all: build

s:
	npx @11ty/eleventy --serve

build:
	npx @11ty/eleventy

clean:
	rm -rf _site
	rm -rf .cache

over: clean build

install:
	rm -rf node_modules
	npm install

.PHONY: all s clean over install
