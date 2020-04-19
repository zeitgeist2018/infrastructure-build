#!/bin/bash

ROOT=$(pwd)
source ./configure-local-dns.sh
source ./ssl.sh

function startReverseProxy() {
  echo "Starting reverse proxy"
  cd "$ROOT/reverse-proxy"
  docker-compose up -d
  cd ..
}

function startDnsServer() {
  cd "$ROOT"
  docker-compose up -d
}

function restartDnsServer() {
  cd "$ROOT"
  docker-compose restart
}

function installDependencies(){
  sudo apt-get install jq resolvconf -y > /dev/null 2>&1
}

function disableDefaultDns(){
  echo "Disabling default system DNS"
  echo "DNSStubListener=no" | sudo tee -a /etc/systemd/resolved.conf
  sudo service systemd-resolved restart
}

installDependencies
generateCertificates
startReverseProxy
startDnsServer
disableDefaultDns
restartDnsServer
fetchDnsServerSettings vm
configureDns
