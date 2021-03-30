# syntax = docker/dockerfile:1.2
FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive \
  && echo steam steam/question select "I AGREE" | debconf-set-selections \
  && dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get install -y --no-install-recommends steamcmd ca-certificates locales \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen \
  && rm -rf /var/lib/apt/lists/*

ENV PATH=/usr/games:$PATH

RUN useradd -rms /bin/bash -d /gameserver gameserver

USER gameserver

RUN steamcmd +quit && rm -rf /tmp/dumps

WORKDIR /gameserver

VOLUME /gameserver/.steam

CMD ["/bin/bash"]
