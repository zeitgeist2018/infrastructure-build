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

function pullDnsImage(){
  docker pull strm/dnsmasq:latest
}
function disableDefaultDns(){
  echo "Disabling default system DNS"
  echo "DNSStubListener=no" | sudo tee -a /etc/systemd/resolved.conf
  sudo service systemd-resolved restart
}

function addCertificatesToDocker(){
  cd "$ROOT/reverse-proxy/ssl"
#  sudo cp cacert.pem /usr/local/share/ca-certificates/
#  sudo update-ca-certificates
  sudo mkdir -p /etc/docker/certs.d/"$ARTIFACTORY_JCR_DOMAIN"
  sudo cp cacert.pem /etc/docker/certs.d/"$ARTIFACTORY_JCR_DOMAIN"/ca.crt
  sudo chmod 644 /etc/docker/certs.d/"$ARTIFACTORY_JCR_DOMAIN"/ca.crt
  sudo service docker restart
}
installDependencies
generateCertificates
startReverseProxy
pullDnsImage
disableDefaultDns || true
startDnsServer || true
restartDnsServer || true
fetchDnsServerSettings vm
configureDns
addCertificatesToDocker
