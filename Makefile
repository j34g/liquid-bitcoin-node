# Makefile for building the Liquid Node package

# Fetch the package version and ID from the manifest
PKG_VERSION := $(shell yq e ".version" manifest.yaml)
PKG_ID := $(shell yq e ".id" manifest.yaml)

.DELETE_ON_ERROR:

all: verify

clean:
	rm -f $(PKG_ID).s9pk
	rm -f docker-images/*.tar

verify: $(PKG_ID).s9pk
	@start-sdk verify s9pk $(PKG_ID).s9pk
	@echo " Done!"
	@echo "   Filesize: $(shell du -h $(PKG_ID).s9pk) is ready"

$(PKG_ID).s9pk: manifest.yaml docker-images/x86_64.tar instructions.md icon.png LICENSE
	@echo "start-sdk: Preparing package ..."
	@start-sdk pack

docker-images/x86_64.tar: Dockerfile docker-entrypoint.sh manifest.yaml
	mkdir -p docker-images
	docker buildx build --tag start9/$(PKG_ID)/main:$(PKG_VERSION) --platform=linux/amd64 -o type=docker,dest=docker-images/x86_64.tar .

install: $(PKG_ID).s9pk
ifeq (,$(wildcard ./start9/config.yaml))
	@echo; echo "You must define \"host: http://server-name.local\" in ./start9/config.yaml config file first"; echo
else
	start-cli package install $(PKG_ID).s9pk
endif