#!/bin/sh
sudo yum update -y && sudo yum install -y \
     curl \
     gnupg2 \
     vim \
     fail2ban \
     ntfs-3g
amazon-linux-extras install -y docker
service docker start
usermod -a -G docker ec2-user
pip3 install docker-compose
mkdir -p ~/plex
cd ~/plex/
wget https://raw.githubusercontent.com/alvarodcr/plex-rpi/master/.env
wget https://raw.githubusercontent.com/alvarodcr/plex-rpi/master/docker-compose.yaml
docker-compose up -d
docker stop plex_transmission_1
cd /transmission/
jq '.rpc-whitelist-enabled |= false' config.json > config.json.tmp && mv config.json.tmp config.json
docker start plex_transmission_1
