build: build-base build-he build-graal

build-base:
	@docker build -f Dockerfile -t saxon:base .

build-he:
	@docker build -f Dockerfile-he -t saxon:he .

build-graal:
	@docker build -f Dockerfile-graal -t saxon:graal .

tag-base:
	@docker tag saxon:base klakegg/saxon:dev-base

tag-he:
	@docker tag saxon:he klakegg/saxon:dev-he

tag-graal:
	@docker tag saxon:graal klakegg/saxon:dev-graal
