SHELL := /bin/bash

NAMESPACE=deltastream
COMPONENT=docs-ui

BUILD_TIME=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
RELEASE_VERSION = 'v0.0.1'

# version format: <last github version>-dirty-<sha>, ex: 0.0.1-dirty-sds342
VERSION ?= $(shell git describe --always --tags `git rev-list --tags --max-count=1` | cut -c2-)$(shell [[ -z $$(git status --porcelain) ]] || echo "-dirty-$(shell git rev-parse --short HEAD)")
VCS_REF:=$(shell git rev-parse --short HEAD)
ts := $(shell /bin/date "+%Y-%m-%d---%H-%M-%S")

.PHONY: init build deploy

timestamp:
	@echo "-----------------"
	@echo Timestamp = $(ts)
	@echo "-----------------"

default: install

info: timestamp
	@echo Version = $(VERSION)

usage: timestamp
	@echo "docs-ui build"
	@echo " "
	@echo "Usage: provides usage for make targets."
	@echo " make build  - runs the build process."
	@echo " make deploy - deploys the service."
	@echo " "

install:
	npm install

preview:
	gulp preview

bundle:
	SOURCEMAPS=true gulp bundle

release:
	gh auth login
	gh release create ${RELEASE_VERSION} build/*.zip

clean:
	rm -rf build/* && \
	rm -rf public/_/css && \
	rm -rf public/_/js


