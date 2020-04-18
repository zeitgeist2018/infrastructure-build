#!/bin/bash

ROOT=$(pwd)
source ./configure-local-dns.sh

function startReverseProxy() {
  echo "Starting reverse proxy"
  cd "$ROOT/reverse-proxy"
  docker-compose up -d
  cd ..
}

function startDnsServer() {
  cd "$ROOT/reverse-proxy"
  docker-compose up -d
}

function installDependencies(){
  sudo apt-get install jq resolvconf -y > /dev/null 2>&1
}

installDependencies
startReverseProxy
startDnsServer
fetchDnsServerSettings vm
configureDns
