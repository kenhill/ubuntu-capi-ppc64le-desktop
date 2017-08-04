FROM ppc64le/ubuntu:xenial
MAINTAINER IBM

# upstart fixes
# init-fake.conf from https://raw.githubusercontent.com/tianon/dockerfiles/master/sbin-init/ubuntu/upstart/14.04/init-fake.conf
ADD init-fake.conf /etc/init/fake-container-events.conf
RUN rm /usr/sbin/policy-rc.d; \
	rm /sbin/initctl; dpkg-divert --rename --remove /sbin/initctl
RUN echo '# /lib/init/fstab: cleared out for bare-bones Docker' >/lib/init/fstab

# base OS
ARG DEBIAN_FRONTEND=noninteractive
ADD https://github.com/nimbix/image-common/archive/master.zip /tmp/nimbix.zip
WORKDIR /tmp
RUN apt-get update && apt-get -y install sudo zip unzip && unzip nimbix.zip && rm -f nimbix.zip
RUN /tmp/image-common-master/setup-nimbix.sh
RUN touch /etc/init.d/systemd-logind && apt-get update && apt-get -y install xz-utils openssh-server libpam-systemd libmlx4-1 libmlx5-1 iptables infiniband-diags && apt-get clean && locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

# Nimbix JARVICE emulation
EXPOSE 22
RUN mkdir -p /usr/lib/JARVICE && cp -a /tmp/image-common-master/tools /usr/lib/JARVICE
RUN ln -s /usr/lib/JARVICE/tools/noVNC/images/favicon.png /usr/lib/JARVICE/tools/noVNC/favicon.png && ln -s /usr/lib/JARVICE/tools/noVNC/images/favicon.png /usr/lib/JARVICE/tools/noVNC/favicon.ico
WORKDIR /usr/lib/JARVICE/tools/noVNC/utils
RUN ln -s websockify /usr/lib/JARVICE/tools/noVNC/utils/websockify.py && ln -s websockify /usr/lib/JARVICE/tools/noVNC/utils/wsproxy.py
WORKDIR /tmp
RUN cp -a /tmp/image-common-master/etc /etc/JARVICE && chmod 755 /etc/JARVICE && rm -rf /tmp/image-common-master
RUN mkdir -m 0755 /data && chown nimbix:nimbix /data

ARG DEBIAN_FRONTEND=noninteractive
ADD https://github.com/nimbix/image-common/archive/master.zip /tmp/nimbix.zip
WORKDIR /tmp
RUN apt-get update && apt-get -y install zip unzip && unzip nimbix.zip && rm -f nimbix.zip

# Nimbix desktop (does an apt-get clean)
RUN mkdir -p /usr/local/lib/nimbix_desktop && for i in help-tiger.html install-ubuntu-tiger.sh nimbix_desktop postinstall-tiger.sh url.txt xfce4-session-logout share skel.config; do cp -a /tmp/image-common-master/nimbix_desktop/$i /usr/local/lib/nimbix_desktop; done && cp -a /tmp/image-common-master/nimbix-desktop-upstart.conf /etc/init/nimbix-desktop.conf && rm -rf /tmp/image-common-master

# Replace rc.local
RUN echo "#!/bin/sh -e" > /etc/rc.local && echo "/usr/local/bin/nimbix_desktop" >> /etc/rc.local && chmod +x /etc/rc.local

# Install TigerVNC ppc64le
ADD tigervnc-Linux-ppc64le-1.7.1.tar.gz /
# Replace install-ubuntu-tiger.sh
ADD install-ubuntu-tiger.sh /usr/local/lib/nimbix_desktop/install-ubuntu-tiger.sh
# Add missing packages for Xenial
RUN apt-get -y install net-tools libmd-dev

RUN /usr/local/lib/nimbix_desktop/install-ubuntu-tiger.sh && ln -s /usr/local/lib/nimbix_desktop /usr/lib/JARVICE/tools/nimbix_desktop

# recreate nimbix user home to get the right skeleton files
RUN /bin/rm -rf /home/nimbix && /sbin/mkhomedir_helper nimbix

# for standalone use
EXPOSE 5901
EXPOSE 443

# Clone and build CAPI tools
RUN apt-get -y install git build-essential vim
WORKDIR /tmp 
RUN git clone https://github.com/ibm-capi/libcxl && cd libcxl && make && cp libcxl.h /usr/local/include && cp libcxl.so* /usr/local/lib
RUN cd /tmp && rm -rf libcxl

