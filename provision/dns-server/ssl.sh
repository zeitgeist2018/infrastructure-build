#!/bin/bash

function generateCertificates(){
  echo "Generating SSL certificates"
  ROOT=$(pwd)
#  installCertbot
  sudo apt-get install letsencrypt -y

  cd "$ROOT/reverse-proxy"
  mkdir ssl
  cd ssl
  CERT_NAME="dev.local.crt"
  KEY_NAME="dev.local.private.key"
  sudo openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
   -keyout $KEY_NAME -out $CERT_NAME \
   -subj "/C=ES/ST=Madrid/L=Madrid/O=Infrastructure-build/CN=dev.local"

  sudo openssl x509 -outform pem -out dev.local.pem -in $CERT_NAME
}
