FROM ubuntu:18.04
ENV CC gcc-7
ENV CXX g++-7
ENV ROOTSYS /root
ENV LD_LIBRARY_PATH /usr/lib/python3.6/dist-packages/:/usr/local/lib:/usr/local/lib/python3.6/site-packages/yoda:$ROOTSYS/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH /usr/lib/python3.6/dist-packages/:/usr/local/lib:/usr/local/lib/python3.6/site-packages:$ROOTSYS/lib:$PYTHONPATH

ENV ROOT_BINARY root_v6.14.00.Linux-ubuntu18-x86_64-gcc7.3.tar.gz
ENV YODA_VERSION 1.7.7

COPY requirements.txt /tmp/requirements.txt

RUN apt-get -y update && apt-get install -y \
python3 \
git \
dpkg-dev \
make \
g++-7 \
gcc-7 \
binutils \
python-dev \
libboost1.62-all-dev \
wget \
python3-pip \
# required by matplotlib
libfreetype6-dev \
pkg-config \
libpng-dev \
libyaml-dev

RUN cd / && wget https://root.cern.ch/download/$ROOT_BINARY && tar -xzf $ROOT_BINARY

RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2

RUN cd /tmp && wget -O YODA-$YODA_VERSION.tar.gz https://yoda.hepforge.org/downloads/?f=YODA-$YODA_VERSION.tar.gz && tar -xzf YODA-$YODA_VERSION.tar.gz && cd YODA-$YODA_VERSION && ./configure && make -j4 && make install && cd ..

RUN pip3 install -i https://pypi.python.org/simple/ --upgrade pip

RUN apt-get -y remove python3-pip

RUN pip install --ignore-installed -r /tmp/requirements.txt && rm /tmp/requirements.txt
