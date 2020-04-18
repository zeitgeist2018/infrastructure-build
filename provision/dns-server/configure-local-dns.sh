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
  sudo systemctl status resolvconf.service >/dev/null 2>&1 ||
    (
      printf "${RED}You need to start resolvconf service${NC}"
      exit 1
    )

  cat <EOF >>sudo /etc/resolvconf/resolv.conf.d/head
  search $DOMAIN
  nameserver $DNS_SERVER
  nameserver $DEFAULT_DNS_1
  nameserver $DEFAULT_DNS_2
  EOF

  sudo systemctl start resolvconf.service
  echo "Final resolv.conf content"
  cat /etc/resolv.conf
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
