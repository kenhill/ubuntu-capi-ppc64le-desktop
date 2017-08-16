#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build -t tigervnc-build:latest $ROOT_DIR/docker_tiger
docker run --rm -v /tmp:/data:rw tigervnc-build
docker rmi tigervnc-build:latest
cp /tmp/tigervnc-Linux*.tar.gz $ROOT_DIR

mv tigervnc-Linux*.tar.gz $ROOT_DIR/docker_ubuntu
docker build -t ubuntu-capi-ppc64le-desktop:latest $ROOT_DIR/docker_ubuntu

