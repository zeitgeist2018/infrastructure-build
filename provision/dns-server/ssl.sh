#!/bin/bash

function generateCertificates(){
  echo "Generating SSL certificates"
  ROOT=$(pwd)

  cd "$ROOT/reverse-proxy/ssl"
  SERVER_CERT="servercert.pem"
  SERVER_KEY="serverkey.pem"

  # Create CA
  openssl req -x509 -config openssl-ca.cnf \
    -newkey rsa:4096 -sha256 -nodes -out cacert.pem -outform PEM \
    -subj "/C=ES/ST=Madrid/L=Madrid/O=Infrastructure-build/CN=DevLocalCA"


  # Create certificate request
  sudo openssl req -config openssl-server.cnf -newkey rsa:2048 \
    -sha256 -nodes -out servercert.csr -outform PEM \
    -subj "/C=ES/ST=Madrid/L=Madrid/O=Infrastructure-build/CN=*.dev.local"

  # Sign certificate with CA
  openssl ca -batch -config openssl-ca.cnf -policy signing_policy \
    -extensions signing_req -out servercert.pem -infiles servercert.csr
}
