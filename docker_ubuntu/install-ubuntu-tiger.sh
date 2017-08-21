#!/bin/bash -ex
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


# VGL64="http://sourceforge.net/projects/virtualgl/files/2.5/virtualgl_2.5_amd64.deb/download"
dirname=$(dirname $0)

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install wget python python-gtk2 gnome-icon-theme-full humanity-icon-theme tango-icon-theme xfce4 xfce4-terminal fonts-freefont-ttf xfonts-base xfonts-100dpi xfonts-75dpi xfonts-scalable xauth firefox librtmp-dev mesa-utils
cd /tmp
# wget --content-disposition "$VGL64"
# dpkg --install virtualgl*.deb || apt-get -f install
# rm -f virtualgl*.deb
apt-get clean

. $dirname/postinstall-tiger.sh
