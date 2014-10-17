.PHONEY: all build

include settings.make

all: build debug

build:
	docker build --tag ${IMAGE_NAME} .

debug: build
	docker run --tty \
						 --interactive \
						 --rm \
						 ${IMAGE_NAME} \
						 /bin/bash

