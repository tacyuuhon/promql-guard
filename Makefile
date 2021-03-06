include Makefile.common

DOCKER_IMAGE_NAME ?= promql-guard

# test-flags = -v

style:
	@echo skip common-style

check_license:
	@echo skip common-check_license

lint:
	@echo skip common-lint

vendor:
	GO111MODULE=$(GO111MODULE) ${GO} mod vendor

.PHONY: clean
clean:
	rm -rf vendor promql-guard

.PHONY: build
build: promu vendor
	@echo ">> building binaries"
	GO111MODULE=$(GO111MODULE) $(PROMU) build --prefix $(PREFIX)

.PHONY: run
run:
	./promql-guard --log.level=debug --log.format=json

.PHONY: ship
ship:
	GO111MODULE=$(GO111MODULE) $(PROMU) crossbuild -p linux/amd64
	GO111MODULE=$(GO111MODULE) $(PROMU) crossbuild -p linux/amd64 tarballs
