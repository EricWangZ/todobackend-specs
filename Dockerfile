FROM ubuntu:trusty
MAINTAINER Eric Wang <eric.z.wang@ericsson.com>

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set mirrors to NZ
# RUN sed -i "s/http:\/\/archive./http:\/\/nz.archive./g" /etc/apt/sources.list 

#ENV http_proxy=http://10.175.250.81:8080
#ENV https_proxy=http://10.175.250.81:8080
#ENV ftp_proxy=http://10.175.250.81:8080
#ENV proxy=http://10.175.250.81:8080
#ENV no_proxy=ericsson.se,127.0.0.1,10.175.172.111,10.175.172.67,10.175.172.68,10.175.172.108,yum.linux.ericsson.se


# Install node.js
RUN apt-get update && \
    apt-get install curl -y && \
#    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
#    apt-get install -y nodejs && \
    apt-get install -y npm 

#    ln -fs /usr/bin/nodejs /usr/local/bin/node 
#    apt-get install -y nodejs && \
#    apt-get install -y nodejs-legacy 

RUN npm config set strict-ssl false && \
    npm install npm -g && \
    npm install n -g && \
    n latest

COPY . /app
WORKDIR /app

# Install application dependencies
RUN npm install -g mocha && \
    npm install

# Set mocha test runner as entrypoint
ENTRYPOINT ["mocha"]

