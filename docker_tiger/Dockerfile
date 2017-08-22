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

# Create build account
RUN apt-get update && apt-get install -y sudo build-essential
ADD setup-user.sh /tmp/setup-user.sh
RUN chmod 755 /tmp/setup-user.sh
RUN /tmp/setup-user.sh && rm -rf /tmp/setup-user.sh 
# Required packages to build TigerVNC
RUN apt-get update && apt-get install -y git cmake libx11-dev zlib1g-dev libjpeg-turbo8-dev gettext libfltk1.3-dev libxrender-dev
# Required packages to build Xvnc
RUN apt-get install -y autoconf automake autopoint libtool pkg-config bison flex gperf m4 libncurses5-dev intltool llvm libtalloc-dev libgbm1 libmtdev-dev libgcrypt20-dev libssl-dev libmd-dev fontconfig libpng-dev libfreetype6-dev xutils-dev xfonts-utils xserver-xorg-dev libpixman-1-dev x11proto-record-dev x11proto-xcmisc-dev x11proto-bigreqs-dev x11proto-composite-dev

# Required packages for docs
RUN apt-get install -y asciidoc doxygen xmlto xsltproc
# Freedesktop dependencies
RUN apt-get install -y libevdev-dev

# Ubuntu 16.04 bug for xfont
RUN apt-get install -y wget
RUN wget http://ports.ubuntu.com/ubuntu-ports/pool/main/libx/libxfont1/libxfont1-dev_1.5.2-4_ppc64el.deb
RUN dpkg --force-all -i libxfont1-dev_1.5.2-4_ppc64el.deb 

ADD https://www.x.org/archive/individual/xserver/xorg-server-1.18.0.tar.bz2 /usr/src/xorg-server.tar.bz2 
RUN chmod 755 /usr/src/xorg-server.tar.bz2
RUN ln -s /usr/bin/make /usr/bin/gmake

RUN mkdir -p /usr/local/lib/build-tigervnc
ADD build-tigervnc.sh /usr/local/lib/build-tigervnc/build-tigervnc.sh
RUN chmod 755 /usr/local/lib/build-tigervnc/build-tigervnc.sh && ln -s /usr/local/lib/build-tigervnc/build-tigervnc.sh /usr/local/bin/build-tigervnc 

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

CMD /bin/su build -c "cd && /usr/local/bin/build-tigervnc"

