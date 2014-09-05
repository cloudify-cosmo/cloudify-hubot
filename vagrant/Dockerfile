# need to test ubuntu 14.04 docker image since in ubuntu 12.04 there appears to be a problem with running npm install on the repo due to a node-gyp problem.
FROM ubuntu:14.04
MAINTAINER nir0s, nirc@gigaspaces.com

# update local cache
RUN apt-get update

# install 3rd party dependencies
# for ubuntu 12.04 install python-software-properties instead.
RUN apt-get install -y vim && \
    apt-get install -y git && \
    apt-get install -y make gcc g++ && \
    apt-get install -y python python-dev

# install nodejs
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:chris-lea/node.js && \
    apt-get update && \
    apt-get install -y nodejs

# install hubot
RUN npm install -g hubot coffee-script

RUN git clone https://github.com/cloudify-cosmo/cloudify-hubot && \
    cd cloudify-hubot && \
    npm install

# CONFIG PLUGINS
# apply flowdock hubot config
# config announce
# export HUBOT_ANNOUNCE_ROOMS="comma separated list of rooms"
# # config deploy
# export HUBOT_DEPLOY_ROOM="room to deploy to"
# # config dnsimple
# export DNSIMPLE_USERNAME="..."
# export DNSIMPLE_PASSWORD="..."
# # config github plugins
# export  HUBOT_GITHUB_TOKEN
# export  HUBOT_GITHUB_USER
# export  HUBOT_GITHUB_API
# export HUBOT_GITHUB_ORG
# # config hangout
# export HUBOT_HANGOUT_URL
# # config keepalive
# export HUBOT_KEEP_ALIVE_FREQUENCY

# run bot
# bin/hubot --name bot -a flowdock