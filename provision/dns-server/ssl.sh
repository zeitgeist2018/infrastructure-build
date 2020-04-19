#!/bin/bash

function generateCertificates(){
  echo "Generating SSL certificates"
  ROOT=$(pwd)
#  installCertbot
  sudo apt-get install letsencrypt -y

  cd "$ROOT/reverse-proxy"
  mkdir ssl
  cd ssl

  sudo openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
   -keyout dev.local.private.key -out dev.local.crt \
   -subj "/C=ES/ST=Madrid/L=Madrid/O=Infrastructure-build/CN=dev.local"

}
