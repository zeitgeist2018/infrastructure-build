#!/bin/bash
set -e

# sudo apt-get update -y > /dev/null 2>&1
# sudo apt-get install systemd -y > /dev/null 2>&1
# sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
# sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-trusty main'
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common > /dev/null 2>&1
sudo apt-get install -y docker.io > /dev/null 2>&1
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
sudo systemctl restart docker
docker --version

# Install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  > /dev/null 2>&1
sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
