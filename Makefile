default: build test

build: build-base build-ee build-he build-he-graal build-pe

build-base:
	@echo "\n--- Image: base ---"
	@docker build -f Dockerfile -t saxon:base .

build-ee:
	@echo "\n--- Image: ee ---"
	@docker build -f Dockerfile-ee -t saxon:ee .

build-he:
	@echo "\n--- Image: he ---"
	@docker build -f Dockerfile-he -t saxon:he .

build-he-graal:
	@echo "\n--- Image: he-graal ---"
	@docker build -f Dockerfile-he-graal -t saxon:he-graal .

build-pe:
	@echo "\n--- Image: pe ---"
	@docker build -f Dockerfile-pe -t saxon:pe .


test: test-ee test-he test-he-graal test-pe

test-ee:
	@echo "\n--- Test: ee ---"
	@test $(shell docker run --rm -i saxon:ee xslt 2>&1 | grep Saxon-EE | wc -l) = "1"
	@test $(shell docker run --rm -i saxon:ee xquery 2>&1 | grep Saxon-EE | wc -l) = "1"

test-he:
	@echo "\n--- Test: he ---"
	@test $(shell docker run --rm -i saxon:he xslt 2>&1 | grep Saxon-HE | wc -l) = "1"
	@test $(shell docker run --rm -i saxon:he xquery 2>&1 | grep Saxon-HE | wc -l) = "1"

test-he-graal:	
	@echo "\n--- Test: he-graal ---"
	@test $(shell docker run --rm -i saxon:he-graal xslt 2>&1 | grep Saxon-HE | wc -l) = "1"

test-pe:
	@echo "\n--- Test: pe ---"
	@test $(shell docker run --rm -i saxon:pe xslt 2>&1 | grep Saxon-PE | wc -l) = "1"
	@test $(shell docker run --rm -i saxon:pe xquery 2>&1 | grep Saxon-PE | wc -l) = "1"


tag: tag-base tag-ee tag-he tag-he-graal tag-pe

tag-base:
	@docker tag saxon:base klakegg/saxon:edge-base

tag-ee:
	@docker tag saxon:ee klakegg/saxon:edge-ee

tag-he:
	@docker tag saxon:he klakegg/saxon:edge-he

tag-he-graal:
	@docker tag saxon:he-graal klakegg/saxon:edge-he-graal

tag-pe:
	@docker tag saxon:pe klakegg/saxon:edge-pe


push:
	@echo docker push $(shell docker images klakegg/saxon | grep -v "TAG" | sed "s:\s\s*:\::g" | cut -d ':' -f 1,2)