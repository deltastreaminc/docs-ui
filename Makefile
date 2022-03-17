SHELL := /bin/bash

NAMESPACE=deltastream
COMPONENT=docs-ui

BUILD_TIME=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')

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

deploy:
	gulp preview

# Step 1 - Create github release
# make release
# ref: https://cli.github.com/manual/gh_release_create
# Upload all tarballs in a directory as release assets
# $ gh release create v1.2.3 ./dist/*.tgz

# Upload a release asset with a display label
# $ gh release create v1.2.3 '/path/to/asset.zip#My display label'


# Step 2 - Add workflow file to publish package on release.
# https://docs.github.com/en/packages/quickstart

