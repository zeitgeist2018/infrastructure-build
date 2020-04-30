#!/bin/bash

set -e

function checkJq() {
  jq --version >/dev/null 2>&1 || (echo "YOU NEED TO INSTALL JQ BEFORE PROCEEDING" && exit 1)
}

function checkSystemctl() {
  systemctl status resolvconf.service || (echo "YOU NEED TO INSTALL RESOLVCONF BEFORE PROCEEDING" && exit 1)
}

function fetchDnsServerSettings() {
  if [ "$1" == "vm" ]; then
    echo "Configuring DNS for VM"
    export DNS_SERVER=127.0.0.1
  else
    echo "Configuring DNS for host"
    checkJq
    export DNS_SERVER=$(cat config.json | jq -r .ip)
  fi

  export DEFAULT_DNS_1=8.8.8.8
  export DEFAULT_DNS_2=8.8.4.4
  export DOMAIN="local"
}

function setDnsServerMacos() {
  sudo networksetup -setdnsservers Wi-Fi $DNS_SERVER $DEFAULT_DNS_1 $DEFAULT_DNS_2
  sudo networksetup -setsearchdomains Wi-Fi $DOMAIN

  sudo networksetup -setdnsservers Ethernet $DNS_SERVER $DEFAULT_DNS_1 $DEFAULT_DNS_2
  sudo networksetup -setsearchdomains Ethernet $DOMAIN
}

function setDnsServerLinux() {
  sudo systemctl status resolvconf.service || (echo "YOU NEED TO INSTALL RESOLVCONF BEFORE PROCEEDING" && exit 1)
cat <<EOF > tmp
search $DOMAIN
nameserver $DNS_SERVER
nameserver $DEFAULT_DNS_1
nameserver $DEFAULT_DNS_2
EOF
  sudo mv tmp /etc/resolvconf/resolv.conf.d/head
  sudo systemctl restart resolvconf.service
}

function configureDns() {
  case "$OSTYPE" in
  darwin*) setDnsServerMacos ;;
  linux*) setDnsServerLinux ;;
  *)
    printf "${RED}Operating System $OSTYPE not supported for now${NC}"
    exit 1
    ;;
  esac
}
