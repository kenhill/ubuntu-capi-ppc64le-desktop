FROM supnim.aus.stglabs.ibm.com:5043/ubuntu-desktop-ppc64le:xenial
MAINTAINER IBM

# Clone and build CAPI tools
RUN apt-get -y install git build-essential vim
WORKDIR /tmp 
RUN git clone https://github.com/ibm-capi/libcxl && cd libcxl && make && cp libcxl.h /usr/local/include && cp libcxl.so* /usr/local/lib
RUN cd /tmp && rm -rf libcxl

