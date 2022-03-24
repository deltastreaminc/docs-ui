SHELL := /bin/bash

NAMESPACE=deltastream
COMPONENT=docs-ui

BUILD_TIME=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
RELEASE_VERSION = 'v0.0.1'

# version format: <last github version>-dirty-<sha>, ex: 0.0.1-dirty-sds342
VERSION ?= $(shell git describe --always --tags `git rev-list --tags --max-count=1` | cut -c2-)$(shell [[ -z $$(git status --porcelain) ]] || echo "-dirty-$(shell git rev-parse --short HEAD)")
VCS_REF:=$(shell git rev-parse --short HEAD)
ts := $(shell /bin/date "+%Y-%m-%d---%H-%M-%S")

.PHONY: info install live build release clean

timestamp:
	@echo "-----------------"
	@echo Timestamp = $(ts)
	@echo "-----------------"

default: install

info: timestamp
	@echo Version = $(VERSION)

usage:
	@echo "docs-ui build"
	@echo " "
	@echo "Usage:"
	@echo " make install - install npm dependencies."
	@echo " make build  - builds ui bundle."
	@echo " make live    - runs live preview."
	@echo " make clean   - cleans the build directory."
	@echo " "

install:
	npm install

live:
	npm run live

build:
	npm run bundle

release:
	RELEASE_VERSION=${RELEASE_VERSION} npm run release

clean:
	npm run clean


