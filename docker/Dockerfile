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
        rm -rf /var/lib/apt/lists/*

# add certificates
ADD ./certs /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Set environment variable to Docker
ENV CONTAINER DOCKER

RUN cd /root && curl -sS -k -O https://ops.stackstorm.net/releases/st2/scripts/st2_deploy.sh

# install docker 1.6
RUN cd /bin &&  curl -L https://get.docker.com/builds/Linux/x86_64/docker-1.6.0 > docker

ADD . /root/st2/

RUN bash -c 'chmod +x /root/*.sh'

RUN bash -c '/root/st2_deploy.sh stable || exit 2'


#RUN bash -c 'chmod +x /root/st2/*.sh'

# auth service
EXPOSE 9100
# api server
EXPOSE 9101
# webui
EXPOSE 8080
