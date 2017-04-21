FROM supnim.aus.stglabs.ibm.com:5043/ubuntu-capi-ppc64le:xenial
MAINTAINER IBM

ARG DEBIAN_FRONTEND=noninteractive
ADD https://github.com/nimbix/image-common/archive/master.zip /tmp/nimbix.zip
WORKDIR /tmp
RUN apt-get update && apt-get -y install zip unzip && unzip nimbix.zip && rm -f nimbix.zip

# Nimbix desktop (does an apt-get clean)
RUN mkdir -p /usr/local/lib/nimbix_desktop && for i in help-tiger.html install-ubuntu-tiger.sh nimbix_desktop postinstall-tiger.sh url.txt xfce4-session-logout share skel.config; do cp -a /tmp/image-common-master/nimbix_desktop/$i /usr/local/lib/nimbix_desktop; done && cp -a /tmp/image-common-master/nimbix-desktop-upstart.conf /etc/init/nimbix-desktop.conf && rm -rf /tmp/image-common-master

# Copy TigerVNC ppc64le archive
ADD tigervnc-Linux-ppc64le-1.7.1.tar.gz /
# Replace install-ubuntu-tiger to use TigerVNC ppc64le archive
ADD install-ubuntu-tiger.sh /usr/local/lib/nimbix_desktop/install-ubuntu-tiger.sh
# Add missing library (?) 
RUN apt-get install -y libmd-dev

RUN /usr/local/lib/nimbix_desktop/install-ubuntu-tiger.sh && ln -s /usr/local/lib/nimbix_desktop /usr/lib/JARVICE/tools/nimbix_desktop

# recreate nimbix user home to get the right skeleton files
RUN /bin/rm -rf /home/nimbix && /sbin/mkhomedir_helper nimbix

# for standalone use
EXPOSE 5901
EXPOSE 443
