FROM python:2.7.16-slim-stretch

ENV PBR_VERSION=0.10.0

RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  gcc

RUN wget https://github.com/openstack/ceilometer/archive/2015.1.1.zip && unzip 2015.1.1.zip
RUN pip install 'pbr==0.11.0' testrepository
RUN cd ceilometer-2015.1.1 && pip install .

COPY ceilometer.conf.example /
COPY wrapper.sh /

ENTRYPOINT ["/bin/sh", "/wrapper.sh"]
