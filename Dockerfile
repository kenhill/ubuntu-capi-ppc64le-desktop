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

FROM ppc64le/ubuntu:xenial
MAINTAINER IBM

# nimbix account and desktop setup
RUN apt-get update && apt-get -y install curl && apt-get clean
RUN curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh | bash -s -- --setup-nimbix-desktop
EXPOSE 22
EXPOSE 5901
EXPOSE 443

# Clone and build CAPI tools
RUN apt-get update && apt-get -y install git build-essential vim
WORKDIR /tmp 
RUN git clone https://github.com/ibm-capi/libcxl && cd libcxl && make && cp libcxl.h /usr/local/include && cp libcxl.so* /usr/local/lib
RUN cd /tmp && rm -rf libcxl

