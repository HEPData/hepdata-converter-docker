FROM ubuntu:14.04
ENV CC gcc-4.8
ENV CXX g++-4.8
ENV LD_LIBRARY_PATH /usr/lib/python2.7/dist-packages/:/usr/local/lib:/usr/local/lib/python2.7/site-packages/yoda:$LD_LIBRARY_PATH
ENV PYTHONPATH /usr/lib/python2.7/dist-packages/:/usr/local/lib:/usr/local/lib/python2.7/site-packages:$PYTHONPATH

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

RUN cd / && wget https://root.cern.ch/download/root_v6.06.02.Linux-ubuntu14-x86_64-gcc4.8.tar.gz && tar -xvf root_v6.06.02.Linux-ubuntu14-x86_64-gcc4.8.tar.gz
RUN /bin/bash -c ". /root/bin/thisroot.sh"

RUN cd /tmp && wget http://www.hepforge.org/archive/yoda/YODA-1.6.0.tar.gz && tar -xzf YODA-1.6.0.tar.gz && cd YODA-1.6.0 && ./configure && make -j4 && sudo make install && cd ..

RUN pip install --upgrade pip

RUN pip install -r /tmp/requirements.txt && rm /tmp/requirements.txt
