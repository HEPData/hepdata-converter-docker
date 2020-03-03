FROM ubuntu:14.04
ENV CC gcc-4.8
ENV CXX g++-4.8
ENV ROOTSYS /root
ENV LD_LIBRARY_PATH /usr/lib/python2.7/dist-packages/:/usr/local/lib:/usr/local/lib/python2.7/site-packages/yoda:$ROOTSYS/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH /usr/lib/python2.7/dist-packages/:/usr/local/lib:/usr/local/lib/python2.7/site-packages:$ROOTSYS/lib:$PYTHONPATH

ENV ROOT_BINARY root_v6.20.00.Linux-ubuntu14-x86_64-gcc4.8.tar.gz
ENV YODA_VERSION 1.7.7

COPY requirements.txt /tmp/requirements.txt

RUN apt-get -y update && apt-get install -y \
git \
dpkg-dev \
make \
g++-4.8 \
gcc-4.8 \
binutils \
python-dev \
libboost1.54-all-dev \
wget \
python-pip \
# required by matplotlib
libfreetype6-dev \
pkg-config \
libpng12-dev \
libyaml-dev

RUN cd / && wget https://root.cern.ch/download/$ROOT_BINARY && tar -xzf $ROOT_BINARY

RUN cd /tmp && wget -O YODA-$YODA_VERSION.tar.gz https://yoda.hepforge.org/downloads/?f=YODA-$YODA_VERSION.tar.gz && tar -xzf YODA-$YODA_VERSION.tar.gz && cd YODA-$YODA_VERSION && ./configure && make -j4 && sudo make install && cd ..

RUN pip install -i https://pypi.python.org/simple/ --upgrade pip

RUN apt-get -y remove python-pip

RUN pip install --ignore-installed -r /tmp/requirements.txt && rm /tmp/requirements.txt
