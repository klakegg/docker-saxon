build: build-base build-he build-he-graal

build-base:
	@docker build -f Dockerfile -t saxon:base .

build-he:
	@docker build -f Dockerfile-he -t saxon:he .

build-he-graal:
	@docker build -f Dockerfile-he-graal -t saxon:he-graal .

tag: tag-base tag-he tag-he-graal

tag-base:
	@docker tag saxon:base klakegg/saxon:dev-base

tag-he:
	@docker tag saxon:he klakegg/saxon:dev-he

tag-he-graal:
	@docker tag saxon:he-graal klakegg/saxon:dev-he-graal
