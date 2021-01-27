FROM ubuntu:16.04
USER root

RUN apt-get update
RUN apt-get -y install software-properties-common net-tools wget curl nano \
    gcc make automake git dpkg-dev build-essential iputils-ping

RUN apt-get -y install nginx

COPY ./village /var/www

#RUN git -C /var/www clone https://antfeher:password@gitlab.com/threatinformant/conference/villages/darkweb-village.git

RUN service nginx start

#CMD service nginx start && sleep infinity

