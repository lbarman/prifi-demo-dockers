FROM lbarman/prifi-demo:latest
MAINTAINER Ludovic Barman <ludovic.barman@protonmail.com>

ENV DEBIAN_FRONTEND noninteractive                   
ENV TINI_VERSION v0.9.0

RUN rm -f "/etc/apt/sources.list.d/arc-theme.list"

# adds xdotools & update
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \
    && apt-get install -y --no-install-recommends --allow-unauthenticated xdotool nload wireshark wget iptables golang linux-headers-generic nano git

ADD image /

# /prifi2 is only for install
ADD prifi /prifi2 

RUN cd /prifi2 && ./prifi.sh install

EXPOSE 80
WORKDIR /root
ENV GOPATH=/go
ENV WEBSITE=www.youtube.com
ENV HOME=/home/ubuntu \
    SHELL=/bin/bash
ENTRYPOINT ["/startupGUI.sh"]