.PHONEY: all build debug run

include settings.make

all: build run

build:
	docker build --tag ${IMAGE_NAME} .

debug: build
	docker run --tty \
						 --interactive \
						 --rm \
						 --env SECRET_KEY_BASE=$(openssl rand -hex 64) \
						 ${IMAGE_NAME} \
						 /bin/bash

run: build
	docker run --tty \
						 --interactive \
						 --rm \
						 --env SECRET_KEY_BASE=$(openssl rand -hex 64) \
						 ${IMAGE_NAME}
