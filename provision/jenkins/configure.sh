#!/bin/bash

function publishAgentImages(){
  cd agents
  echo "Publishing Jenkins agents docker images"
  ./publish-agent.sh java
}

docker-compose up -d
publishAgentImages

