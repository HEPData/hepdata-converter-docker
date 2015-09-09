FROM ubuntu:14.04
ENV CC gcc-4.8
ENV CXX g++-4.8
ENV ROOTSYS /usr/local/lib/root
ENV LD_LIBRARY_PATH /usr/lib/python2.7/dist-packages/:/usr/local/lib:/usr/local/lib/python2.7/site-packages/yoda:/usr/share/python-support/root/:$LD_LIBRARY_PATH
ENV PYTHONPATH /usr/lib/python2.7/dist-packages/:/usr/local/lib:/usr/local/lib/python2.7/site-packages:/usr/share/python-support/root/:$PYTHONPATH

COPY requirements.txt /tmp/requirements.txt

RUN apt-get -y update && apt-get install -y \
git \
root-system-bin \
libroot-bindings-python5.34 \
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
libpng12-dev

RUN cd /tmp && wget http://www.hepforge.org/archive/yoda/YODA-1.5.1.tar.gz && tar -xzf YODA-1.5.1.tar.gz && cd YODA-1.5.1 && ./configure && make -j4 && sudo make install && cd ..

RUN pip install --upgrade pip

RUN pip install -r /tmp/requirements.txt && rm /tmp/requirements.txt