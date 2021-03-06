# Pull base ubuntu image.
FROM ubuntu:14.04

# Disable prompts
ENV DEBIAN_FRONTEND noninteractive


# Reset policy-rc.d
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# Install Python
RUN \
  apt-get update && \
    apt-get install -y curl python python-dev python-pip python-virtualenv openssh-server && \
      apt-get install -y python-prettytable python-yaml && \
        apt-get install -y ca-certificates && \
           apt-get install -y groff && \
        rm -rf /var/lib/apt/lists/*

# add certificates
ADD ./certs /usr/local/share/ca-certificates/
RUN update-ca-certificates

# env var needed for python to pick up certificates
ENV REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt

# Set environment variable to Docker
ENV CONTAINER DOCKER

# bad way to get docker host; need service discovery
ENV DOCKER_HOST tcp://vw1amaline2-dev.prod.fdic.gov:2376 
ENV DOCKER_TLS_VERIFY 1

RUN cd /root && curl -sS -k -O https://ops.stackstorm.net/releases/st2/scripts/st2_deploy.sh

# install amazon aws command line client
RUN pip install awscli

# install docker 1.6
RUN cd /bin &&  curl -L https://get.docker.com/builds/Linux/x86_64/docker-1.6.0 > docker && chmod u+x docker

ADD . /root/st2/

RUN bash -c 'chmod +x /root/*.sh /root/st2/*.sh'

RUN bash -c '/root/st2_deploy.sh stable || exit 2'
RUN bash -c '/root/st2/start.sh packinstall' && st2ctl stop

# auth service
EXPOSE 9100
# api server
EXPOSE 9101
# webui
EXPOSE 8080
