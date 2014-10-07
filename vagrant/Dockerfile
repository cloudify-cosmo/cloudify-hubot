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

CMD ["export HUBOT_FLOWDOCK_LOGIN_EMAIL=$1 && \
    export HUBOT_FLOWDOCK_LOGIN_PASSWORD=$2 && \
    export HUBOT_FLOWDOCK_IRC_FLOWID=$HUBOT_FLOWDOCK_IRC_FLOWID && \
    export HUBOT_FLOWDOCK_IRC_CHANNEL=$HUBOT_FLOWDOCK_IRC_CHANNEL && \
    export HUBOT_FLOWDOCK_IRC_SERVER=$HUBOT_FLOWDOCK_IRC_SERVER && \
    export HUBOT_FLOWDOCK_IRC_RELAY_CLIENT=$HUBOT_FLOWDOCK_IRC_RELAY_CLIENT && \
    cd /cloudify-hubot && bin/hubot --name $3 -a flowdock"]