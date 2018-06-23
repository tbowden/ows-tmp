FROM ubuntu:xenial

# use ubuntugis stable repo
RUN echo "deb http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial main" > /etc/apt/sources.list.d/ubuntugis-stable.list
RUN echo "deb-src http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial main" >> /etc/apt/sources.list.d/ubuntugis-stable.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 089EBE08314DF160


RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && apt-get install -y \
    --no-install-recommends \
    gosu \
    python3 python3-dev python3-pip
    
RUN gosu nobody true

