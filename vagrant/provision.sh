# update local cache
sudo apt-get update

# install 3rd party dependencies
sudo apt-get install -y python-software-properties vim git make gcc

# install nodejs
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs

# installl hubot
sudo npm install -g hubot coffee-script

# create bot
hubot --create cloudify-hubot

# install bot dependencies
cd cloudify-hubot
npm install

# CONFIG PLUGINS
# apply flowdock hubot config
export HUBOT_FLOWDOCK_LOGIN_EMAIL="..."
export HUBOT_FLOWDOCK_LOGIN_PASSWORD="..."
# config announce
export HUBOT_ANNOUNCE_ROOMS="comma separated list of rooms"
# config deploy
export HUBOT_DEPLOY_ROOM="room to deploy to"
# config dnsimple
export DNSIMPLE_USERNAME="..."
export DNSIMPLE_PASSWORD="..."
# config github plugins
export  HUBOT_GITHUB_TOKEN
export  HUBOT_GITHUB_USER
export  HUBOT_GITHUB_API
export HUBOT_GITHUB_ORG
# config hangout
export HUBOT_HANGOUT_URL
# config keepalive
export HUBOT_KEEP_ALIVE_FREQUENCY

# run bot
bin/hubot --name bot -a flowdock
