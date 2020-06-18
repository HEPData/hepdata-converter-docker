# Based on ROOT project's conda image which uses python3.7
FROM rootproject/root-conda:6.20.00
ENV CC /opt/conda/bin/x86_64-conda_cos6-linux-gnu-cc
ENV CXX /opt/conda/bin/x86_64-conda_cos6-linux-gnu-c++

ENV YODA_VERSION 1.8.2

COPY requirements.txt /tmp/requirements.txt

RUN apt-get -y update && apt-get install -y \
git \
dpkg-dev \
make \
cmake \
binutils \
libboost-all-dev \
wget \
# required by matplotlib
libfreetype6-dev \
pkg-config \
libpng-dev \
libyaml-dev

RUN /bin/bash -c "source /root/.bashrc && cd /tmp && wget -O YODA-$YODA_VERSION.tar.gz https://yoda.hepforge.org/downloads/?f=YODA-$YODA_VERSION.tar.gz && tar -xzf YODA-$YODA_VERSION.tar.gz && cd YODA-$YODA_VERSION && ./configure --with-zlib=/opt/conda --prefix=/opt/conda && make -j4 && make -j4 install && cd ../"

RUN conda install git pip

RUN pip install -r /tmp/requirements.txt && rm /tmp/requirements.txt
