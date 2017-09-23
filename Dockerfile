FROM ubuntu:16.04

MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

#-----------------------------------------------------------------------------
# Install Dependencies
#-----------------------------------------------------------------------------
RUN dpkg --add-architecture i386 \
    && apt-get -y update

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

RUN apt-get -y install curl \
      dosbox \
      p7zip \
      p7zip-full \
      x11vnc \
      xvfb \
      wget

RUN apt-get -y install software-properties-common \
    && add-apt-repository -y ppa:ubuntu-wine/ppa \
    && apt-get -y update

RUN apt-get -y install wine1.8 \
      winetricks

RUN apt-get -y purge software-properties-common \
    && apt-get -y autoclean

#-----------------------------------------------------------------------------
# Run Init Docker Container
#-----------------------------------------------------------------------------
ENTRYPOINT ["/init"]
CMD []