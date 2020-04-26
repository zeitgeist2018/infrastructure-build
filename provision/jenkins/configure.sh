#!/bin/bash

function publishAgentImages(){
  cd agents
  echo "Publishing Jenkins agents docker images"
  ./publish-agent java
}

docker-compose up -d
publishAgentImages

