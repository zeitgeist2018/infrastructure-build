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
      - "{{ .JENKINS_PORT }}:8080"    # TODO: Expose only to 127.0.0.1
    volumes:
      - {{ .DATA_FOLDER }}/jenkins/master:/var/jenkins_home
    networks:
      - net
networks:
  net:
