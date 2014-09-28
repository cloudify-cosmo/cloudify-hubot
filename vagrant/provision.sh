# verify https
[ -e /usr/lib/apt/methods/https ] || {
  apt-get update
  apt-get install -y apt-transport-https
}

# add key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
# add docker repo
sudo sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
# install docker
sudo apt-get update
sudo apt-get install -y lxc-docker
curl -sSL https://get.docker.io/ubuntu/ | sudo sh

HUBOT_CONTAINER_REPO='cosmoadmin/cloudify-hubot'
HUBOT_FLOWDOCK_IRC_FLOWID='080cded7-aeea-446f-a1bb-5f5e09e66f54'
HUBOT_FLOWDOCK_IRC_CHANNEL="#cloudify"
HUBOT_FLOWDOCK_IRC_SERVER="irc.freenode.com"
HUBOT_FLOWDOCK_IRC_RELAY_CLIENT="cosmo-admin"

echo "********************************************"
echo "HUBOT_FLOWDOCK_LOGIN_EMAIL is: $1"
echo "HUBOT_FLOWDOCK_LOGIN_PASSWORD is: $2"
echo "BOT_NAME: $3"
echo "HUBOT_CONTAINER_REPO is: $HUBOT_CONTAINER_REPO"
echo "HUBOT_FLOWDOCK_IRC_FLOWID is: $HUBOT_FLOWDOCK_IRC_FLOWID"
echo "HUBOT_FLOWDOCK_IRC_CHANNEL is: $HUBOT_FLOWDOCK_IRC_CHANNEL"
echo "HUBOT_FLOWDOCK_IRC_SERVER is: $HUBOT_FLOWDOCK_IRC_SERVER"
echo "HUBOT_FLOWDOCK_IRC_RELAY_CLIENT is: $HUBOT_FLOWDOCK_IRC_RELAY_CLIENT"
echo "********************************************"

# run container
sudo docker run -d --name hubot $HUBOT_CONTAINER_REPO /bin/sh -c "export HUBOT_FLOWDOCK_LOGIN_EMAIL=\"$1\" && export HUBOT_FLOWDOCK_LOGIN_PASSWORD=\"$2\" && export HUBOT_FLOWDOCK_IRC_FLOWID=\"$HUBOT_FLOWDOCK_IRC_FLOWID\" && export HUBOT_FLOWDOCK_IRC_CHANNEL=\"$HUBOT_FLOWDOCK_IRC_CHANNEL\" && export HUBOT_FLOWDOCK_IRC_SERVER=\"$HUBOT_FLOWDOCK_IRC_SERVER\" && export HUBOT_FLOWDOCK_IRC_RELAY_CLIENT=\"$HUBOT_FLOWDOCK_IRC_RELAY_CLIENT\" && cd /cloudify-hubot && bin/hubot --name $3 -a flowdock"