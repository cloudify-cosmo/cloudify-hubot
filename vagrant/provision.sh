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

export HUBOT_FLOWDOCK_LOGIN_EMAIL=$1
export HUBOT_FLOWDOCK_LOGIN_PASSWORD=$2
export HUBOT_FLOWDOCK_IRC_FLOWID='080cded7-aeea-446f-a1bb-5f5e09e66f54'
export HUBOT_FLOWDOCK_IRC_CHANNEL='#cloudify'
export HUBOT_FLOWDOCK_IRC_SERVER='irc.freenode.com'
export HUBOT_FLOWDOCK_IRC_RELAY_CLIENT='cosmo-admin'
export HEARTBEAT_INTERVAL='43200000'
export HEARTBEAT_ENABLED='true'
export HEARTBEAT_FLOWID='52e9744a-a699-4342-8aea-b33324583bbc'
# TestBotZone FlowID for tests
# export HEARTBEAT_FLOWID='ca831fe8-860c-45f8-ba34-2c2559b38d70'

echo "********************************************"
echo "HUBOT_FLOWDOCK_LOGIN_EMAIL is: $1"
echo "HUBOT_FLOWDOCK_LOGIN_PASSWORD is: $2"
echo "BOT_NAME: $3"
echo "HUBOT_FLOWDOCK_IRC_FLOWID is: $HUBOT_FLOWDOCK_IRC_FLOWID"
echo "HUBOT_FLOWDOCK_IRC_CHANNEL is: $HUBOT_FLOWDOCK_IRC_CHANNEL"
echo "HUBOT_FLOWDOCK_IRC_SERVER is: $HUBOT_FLOWDOCK_IRC_SERVER"
echo "HUBOT_FLOWDOCK_IRC_RELAY_CLIENT is: $HUBOT_FLOWDOCK_IRC_RELAY_CLIENT"
echo "HUBOT_FLOWDOCK_IRC_RELAY_HEARTBEAT_INTERVAL is: $HEARTBEAT_INTERVAL"
echo "HUBOT_FLOWDOCK_IRC_RELAY_HEARTBEAT_ENABLED is: $HEARTBEAT_ENABLED"
echo "HUBOT_FLOWDOCK_IRC_RELAY_HEARTBEAT_FLOWID is: $HEARTBEAT_FLOWID"
echo "********************************************"

cd /cloudify-hubot &&
bin/hubot --name $3 -a flowdock