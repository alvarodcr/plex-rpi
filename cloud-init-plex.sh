#!/bin/sh
sudo yum update -y && sudo yum install -y \
     gnupg2 \
     fail2ban \
amazon-linux-extras install -y docker
service docker start
usermod -a -G docker ec2-user
pip3 install docker-compose
sudo mkdir -p ~/plex
cd ~/plex/
wget https://raw.githubusercontent.com/alvarodcr/plex-rpi/master/.env
wget https://raw.githubusercontent.com/alvarodcr/plex-rpi/master/docker-compose.yaml
docker-compose up -d
docker stop plex_transmission_1
cd /transmission/
jq '.rpc-whitelist-enabled |= false' config.json
docker start plex_transmission_1
