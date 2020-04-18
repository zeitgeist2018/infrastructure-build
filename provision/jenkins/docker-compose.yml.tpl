version: '3'
services:
  jenkins:
    container_name: jenkins-master
    image: jenkins-master
    hostname: {{ .JENKINS_URL }}
    restart: unless-stopped
    build:
      context: ./master
    ports:
      - "{{ .JENKINS_PORT }}:8080"
    networks:
      - net
networks:
  net:
