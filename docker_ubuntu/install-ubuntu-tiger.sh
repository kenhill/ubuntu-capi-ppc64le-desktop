#!/bin/bash -ex

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
