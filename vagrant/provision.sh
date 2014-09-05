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


echo "********************************************"
echo "HUBOT_CONTAINER_REPO is: $1"
echo "HUBOT_FLOWDOCK_LOGIN_EMAIL is: $2"
echo "HUBOT_FLOWDOCK_LOGIN_PASSWORD is: $3"
echo "********************************************"

# run container
sudo docker run -d --name hubot $1 /bin/sh -c "export HUBOT_FLOWDOCK_LOGIN_EMAIL=\"$2\" && export HUBOT_FLOWDOCK_LOGIN_PASSWORD=\"$3\" && cd /cloudify-hubot && bin/hubot --name bot -a flowdock"