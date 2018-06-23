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

# RUN pip3 install setuptools wheel

RUN pip3 install virtualenvwrapper

RUN adduser --gecos webdev --disabled-password webdev
RUN mkdir -p /usr/local/srss/python/virtualenvs /usr/local/srss/python/projects 

# set so virtualenvwrapper can find python3
ENV VIRTUALENVWRAPPER_PYTHON /usr/bin/python3
# virtualevwrapper variables
ENV WORKON_HOME /usr/local/srss/python/virtualenvs
ENV PROJECT_HOME /usr/local/srss/python/projects

COPY ./include/* /usr/local/srss/python/projects/
RUN chown -R webdev /usr/local/srss

USER webdev
WORKDIR /usr/local/srss/python/projects

RUN ["/bin/bash", "-ic", "mkproject ows_hammer && \
    pip install -r requirements.txt"]


