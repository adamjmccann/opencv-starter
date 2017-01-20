.PHONY: all build build-local build-shell
SHELL=/bin/sh

REPO=opencv-starter
TAGS=latest 0.1

build_image=${REPO}-build
docker_buildargs = --build-arg http_proxy=$(http_proxy) --build-arg https_proxy=$(http_proxy) --build-arg no_proxy=$(no_proxy)
docker_runargs = -v $(shell pwd):/usr/local/src/opencv-starter -w /usr/local/src/opencv-starter
docker = docker run --rm -i ${docker_runargs} ${build_image}

all: build

${build_image}.created:
	docker build ${docker_buildargs} -f docker/Dockerfile.build -t ${build_image} .
	touch ${build_image}.created

build: ${build_image}.created
	@echo "Building ... "
	@${docker} ./wrapmake.sh build-local
	@echo "Done building"

build-local:
	cmake -H. -B/tmp/build
	cd build \
	&& make \
	&& make install

build-shell: ${build_image}.created
	@docker run --rm -it ${docker_runargs} ${build_image} /bin/bash

clean:
	@if [ $(shell docker ps -a | grep $(build_image) | wc -l) != 0 ]; then \
		docker ps -a | grep $(build_image) | awk '{print $$1}' | xargs docker rm -f; \
	fi
	@if [ $(shell docker images | grep $(build_image) |  wc -l) != 0 ]; then \
		docker images | grep $(build_image) | awk '{print $$3}' | xargs docker rmi -f || true; \
	fi
	@if [ -f $(build_image).created ]; then \
		rm $(build_image).created; \
	fi
