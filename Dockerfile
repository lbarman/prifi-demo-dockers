FROM lbarman/prifi-demo:base
MAINTAINER Ludovic Barman <ludovic.barman@protonmail.com>

ENV DEBIAN_FRONTEND noninteractive                   
ENV TINI_VERSION v0.9.0

# adds xdotools
RUN apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated xdotool nload wireshark iptables \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ADD image /

EXPOSE 80
WORKDIR /root
ENV WEBSITE=www.youtube.com
ENV HOME=/home/ubuntu \
    SHELL=/bin/bash
ENTRYPOINT ["/startupGUI.sh"]
