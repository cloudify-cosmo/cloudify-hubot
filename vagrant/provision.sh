# update local cache
sudo apt-get update

# install 3rd party dependencies
# for ubuntu 12.04 install python-software-properties instead.
sudo apt-get install -y vim &&
sudo apt-get install -y git &&
sudo apt-get install -y make gcc g++ &&
sudo apt-get install -y python python-dev

# install nodejs
sudo apt-get install -y software-properties-common &&
sudo add-apt-repository -y ppa:chris-lea/node.js &&
sudo apt-get update &&
sudo apt-get install -y nodejs

# install hubot
sudo npm install -g hubot coffee-script

sudo git clone https://github.com/cloudify-cosmo/cloudify-hubot &&
cd cloudify-hubot &&
sudo npm install

HUBOT_FLOWDOCK_IRC_FLOWID='080cded7-aeea-446f-a1bb-5f5e09e66f54'
HUBOT_FLOWDOCK_IRC_CHANNEL='#cloudify'
HUBOT_FLOWDOCK_IRC_SERVER='irc.freenode.com'
HUBOT_FLOWDOCK_IRC_RELAY_CLIENT='cosmo-admin'

echo "********************************************"
echo "HUBOT_FLOWDOCK_LOGIN_EMAIL is: $1"
echo "HUBOT_FLOWDOCK_LOGIN_PASSWORD is: $2"
echo "BOT_NAME: $3"
echo "HUBOT_FLOWDOCK_IRC_FLOWID is: $HUBOT_FLOWDOCK_IRC_FLOWID"
echo "HUBOT_FLOWDOCK_IRC_CHANNEL is: $HUBOT_FLOWDOCK_IRC_CHANNEL"
echo "HUBOT_FLOWDOCK_IRC_SERVER is: $HUBOT_FLOWDOCK_IRC_SERVER"
echo "HUBOT_FLOWDOCK_IRC_RELAY_CLIENT is: $HUBOT_FLOWDOCK_IRC_RELAY_CLIENT"
echo "********************************************"

export HUBOT_FLOWDOCK_LOGIN_EMAIL=$1 &&
export HUBOT_FLOWDOCK_LOGIN_PASSWORD=$2 &&
export HUBOT_FLOWDOCK_IRC_FLOWID=$HUBOT_FLOWDOCK_IRC_FLOWID &&
export HUBOT_FLOWDOCK_IRC_CHANNEL=$HUBOT_FLOWDOCK_IRC_CHANNEL &&
export HUBOT_FLOWDOCK_IRC_SERVER=$HUBOT_FLOWDOCK_IRC_SERVER &&
export HUBOT_FLOWDOCK_IRC_RELAY_CLIENT=$HUBOT_FLOWDOCK_IRC_RELAY_CLIENT &&
cd /cloudify-hubot &&
bin/hubot --name $3 -a flowdock