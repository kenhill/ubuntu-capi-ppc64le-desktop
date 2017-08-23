#!/bin/bash
#
# Copyright 2017 International Business Machines
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build -t tigervnc-build:latest $ROOT_DIR/docker_tiger
docker run --rm -v /tmp:/data:rw tigervnc-build
docker rmi tigervnc-build:latest
cp /tmp/tigervnc-Linux*.tar.gz $ROOT_DIR

mv tigervnc-Linux*.tar.gz $ROOT_DIR/docker_ubuntu
docker build -t ubuntu-capi-ppc64le-desktop:latest $ROOT_DIR/docker_ubuntu
rm $ROOT_DIR/docker_ubuntu/tigervnc-Linux*.tar.gz

