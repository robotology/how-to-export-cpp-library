FROM ubuntu:xenial

RUN echo "deb http://www.icub.org/ubuntu xenial contrib/science" > /etc/apt/sources.list.d/icub.list

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 57A5ACB6110576A6 

RUN apt-get update -y
RUN apt-get install -y icub-common
