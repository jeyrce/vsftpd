
buildAt:=$(shell date "+%Y-%m-%d %H:%M:%S")
commitId:=$(shell git rev-parse --short HEAD)
branch:=$(shell git symbolic-ref --short -q HEAD)
version:=latest
imageName:=jeyrce/vsftpd:${version}

.phony: all
all: image 
	@echo "make all"

.phony: image
image:
	-docker buildx rm tmp
	docker buildx create --name tmp --bootstrap --use
	docker buildx build -t ${imageName} \
		--build-arg commitId=${commitId} \
		--build-arg goProxy=${goProxy} \
		--platform linux/386,linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v8 \
		--push \
		.
