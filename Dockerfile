FROM ubuntu:16.04
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV WINE_MONO_VERSION 4.5.6
ENV WINE_GECKO_VERSION 2.40

#-----------------------------------------------------------------------------
# Install Dependencies
#-----------------------------------------------------------------------------
USER root
RUN echo "deb http://archive.ubuntu.com/ubuntu xenial main restricted universe multiverse > /etc/apt/sources.list" \
    && echo "deb-src http://archive.ubuntu.com/ubuntu xenial main restricted universe multiverse >> /etc/apt/sources.list" \
    && echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main restricted universe multiverse >> /etc/apt/sources.list" \
    && echo "deb-src http://archive.ubuntu.com/ubuntu xenial-updates main restricted universe multiverse >> /etc/apt/sources.list" \
    && echo "deb http://archive.ubuntu.com/ubuntu xenial-backports main restricted universe multiverse >> /etc/apt/sources.list" \
    && echo "deb-src http://archive.ubuntu.com/ubuntu xenial-backports main restricted universe multiverse >> /etc/apt/sources.list" \
    && echo "deb http://archive.ubuntu.com/ubuntu xenial-security main restricted universe multiverse >> /etc/apt/sources.list" \
    && echo "deb-src http://archive.ubuntu.com/ubuntu xenial-security main restricted universe multiverse >> /etc/apt/sources.list" \
    && echo "deb http://archive.canonical.com/ubuntu xenial partner >> /etc/apt/sources.list" \
    && echo "deb-src http://archive.canonical.com/ubuntu xenial partner >> /etc/apt/sources.list" \
    && apt-get -y update

RUN apt-get -y install --no-install-recommends \
      curl \
      unzip \
      ca-certificates \
      software-properties-common \
    && add-apt-repository -y ppa:ubuntu-wine/ppa

RUN dpkg --add-architecture i386 \
    && apt-get -y update \
    && apt-get -y install --no-install-recommends \
         wine1.8 \
         wine-gecko$WINE_GECKO_VERSION:i386 \
         wine-gecko$WINE_GECKO_VERSION:amd64 \
         wine-mono$WINE_MONO_VERSION \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -y install curl \
      dosbox \
      p7zip \
      p7zip-full \
      x11vnc \
      xvfb \
      wget

RUN curl -SL 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -o /usr/local/bin/winetricks \
    && chmod +x /usr/local/bin/winetricks

RUN mkdir -p /usr/share/wine/mono \
    && curl -SL 'http://sourceforge.net/projects/wine/files/Wine%20Mono/$WINE_MONO_VERSION/wine-mono-$WINE_MONO_VERSION.msi/download' -o /usr/share/wine/mono/wine-mono-$WINE_MONO_VERSION.msi \
    && chmod +x /usr/share/wine/mono/wine-mono-$WINE_MONO_VERSION.msi

RUN apt-get -y purge software-properties-common \
    && apt-get -y autoclean

USER zeroc0d3
ENV HOME /home/zeroc0d3 \
    WINEPREFIX /home/zeroc0d3/.wine \
    WINEARCH win32
    WINEDEBUG -all

WORKDIR /home/zeroc0d3

RUN echo "alias winegui='wine explorer /desktop=DockerDesktop,1024x768'" > ~/.bash_aliases

#-----------------------------------------------------------------------------
# Run Init Docker Container
#-----------------------------------------------------------------------------
CMD []