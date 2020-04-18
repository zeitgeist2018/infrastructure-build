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

deleteAllData
fetchDnsServerSettings
configureDns
redeployVM
