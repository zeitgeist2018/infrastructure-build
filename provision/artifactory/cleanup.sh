#!/bin/bash

cd /home/vagrant/provision

docker-compose kill
docker-compose rm -f
sudo rm -r data/artifactory/*
sudo rm -r data/postgresql/*

sudo chmod 777 data/artifactory
sudo chmod 777 data/postgresql

