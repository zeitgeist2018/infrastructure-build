#!/bin/bash

source ./provision/util.sh
source ./configure-local-dns.sh

function deleteAllData() {
  cd data && find . \! -name '.gitkeep' | xargs rm -r
  cd ..
}

function redeployVM() {
  vagrant destroy -f
  vagrant up
}

function installCertificatesLinux() {
  sudo cp ./data/ssl/*.crt /usr/local/share/ca-certificates/
  sudo update-ca-certificates
}

function installCertificatesMacos() {
  sudo security add-trusted-cert -p ssl -d -r trustRoot \
      -k ~/Library/Keychains/login.keychain ./data/ssl/dev.local.crt
}

function copyCertificatesFromVM(){
  export VM_IP=$(cat config.json | jq -r .ip)
  ssh-keygen -R $VM_IP
  scp -r -o IdentitiesOnly=yes -oStrictHostKeyChecking=no \
    -i .vagrant/machines/default/virtualbox/private_key \
    vagrant@"$VM_IP":/home/vagrant/provision/dns-server/reverse-proxy/ssl ./data
}

function installSSLCertificates() {
  echo "Installing SSL certificates on host"
  copyCertificatesFromVM
  case "$OSTYPE" in
  darwin*) installCertificatesMacos ;;
  linux*) installCertificatesLinux ;;
  *)
    printf "${RED}Operating System $OSTYPE not supported for now${NC}"
    exit 1
    ;;
  esac
}

deleteAllData
fetchDnsServerSettings
configureDns
redeployVM
installSSLCertificates
