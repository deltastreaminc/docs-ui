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

default: install live bundle release clean

info: timestamp
	@echo Version = $(VERSION)

usage: 
	@echo "docs-ui build"
	@echo " "
	@echo "Usage:"
	@echo " make install - install npm dependencies."
	@echo " make bundle  - builds ui bundle."
	@echo " make live    - runs live preview."
	@echo " make clean   - cleans the build directory."
	@echo " make release - generates github release."
	@echo " "

install:
	npm install

live:
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


