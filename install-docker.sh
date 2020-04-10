#!/bin/bash
set -e

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
