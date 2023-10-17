# Based on ROOT project's Ubuntu image which uses Python 3.10
FROM rootproject/root:6.28.04-ubuntu22.04

ENV YODA_VERSION 2.0.0alpha

RUN apt-get -y update && apt-get install -y \
git \
dpkg-dev \
make \
cmake \
binutils \
libboost-all-dev \
wget \
python3-pip \
# required by matplotlib
libfreetype6-dev \
pkg-config \
libpng-dev \
libyaml-dev

RUN /bin/bash -c "source /root/.bashrc && cd /tmp && wget -O YODA-$YODA_VERSION.tar.gz https://yoda.hepforge.org/downloads/?f=YODA-$YODA_VERSION.tar.gz && tar -xzf YODA-$YODA_VERSION.tar.gz && cd YODA-$YODA_VERSION && PYTHON=/usr/bin/python3 ./configure --disable-root && make -j4 && make -j4 install && cd ../"

ENV LD_LIBRARY_PATH /usr/local/lib
