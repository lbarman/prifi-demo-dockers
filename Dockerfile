FROM lbarman/prifi-demo:latest
MAINTAINER Ludovic Barman <ludovic.barman@protonmail.com>

ENV DEBIAN_FRONTEND noninteractive                   
ENV TINI_VERSION v0.9.0

#bug fix
RUN rm -f "/etc/apt/sources.list.d/arc-theme.list"

# adds xdotools & update
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \
    && apt-get install -y --no-install-recommends --allow-unauthenticated xdotool nload wireshark wget iptables linux-headers-generic nano git wget iputils-ping \
    && apt autoremove -y

#install go 1.7
#RUN wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz \
#    && tar -xvf go1.8.3.linux-amd64.tar.gz \
#    && mv go /usr/local

RUN rm -f go1.8.3.linux-amd64.tar.gz

# add files
ADD image /

# /prifi2 is only for install
ADD prifi /prifi2 

RUN cd /prifi2 && ./prifi.sh install

EXPOSE 80
WORKDIR /root
ENV GOPATH=/go \
    GOROOT=/usr/local/go \
    WEBSITE=www.youtube.com \
    HOME=/home/ubuntu \
    SHELL=/bin/bash \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/go/bin:/usr/local/go/bin
ENTRYPOINT ["/startupGUI.sh"]