# Based on ROOT project's ubuntu image which uses python3.8
FROM rootproject/root:6.22.02-ubuntu20.04

ENV YODA_VERSION 1.8.3

COPY requirements.txt /tmp/requirements.txt

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

RUN pip3 install -r /tmp/requirements.txt && rm /tmp/requirements.txt

ENV LD_LIBRARY_PATH /usr/local/lib
