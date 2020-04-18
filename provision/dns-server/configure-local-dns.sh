#!/bin/bash

function checkJq() {
  jq --version >/dev/null 2>&1 || (echo "You need to install jq before proceeding" && exit 1)
}

function checkSystemctl() {
  systemctl status resolvconf.service || (echo "You need to install resolvconf before proceeding" && exit 1)
}

checkJq

function fetchDnsServerSettings() {
  if [ "$1" == "vm" ]; then
    echo "Configuring DNS for VM"
    export DNS_SERVER=0.0.0.0
  else
    echo "Configuring DNS for host"
    export DNS_SERVER=$(cat config.json | jq -r .ip)
  fi

  export DOMAIN="local"
}

function setDnsServerMacos() {
  sudo networksetup -setdnsservers Wi-Fi $DNS_SERVER
  sudo networksetup -setsearchdomains Wi-Fi $DOMAIN
  sudo networksetup -setdnsservers Ethernet $DNS_SERVER
  sudo networksetup -setsearchdomains Ethernet $DOMAIN
}

function setDnsServerLinux() {
  sudo systemctl status resolvconf.service >/dev/null 2>&1 ||
    (
      printf "${RED}You need to start resolvconf service${NC}"
      exit 1
    )

  cat <EOF >>sudo /etc/resolvconf/resolv.conf.d/head
  nameserver $IP
  EOF
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
