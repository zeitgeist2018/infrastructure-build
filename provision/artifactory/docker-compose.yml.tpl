version: '2'
services:
  postgresql:
    image: postgres:9.6.17
    container_name: artifactory-postgresql
    ports:
      - 5432:5432    # TODO: Expose only to 127.0.0.1
    environment:
      - POSTGRES_DB=artifactory
      - POSTGRES_USER=artifactory
      - POSTGRES_PASSWORD=password
    volumes:
      - /home/vagrant/data/postgresql:/var/lib/postgresql/data
    restart: unless-stopped
    ulimits:
      nproc: 65535
      nofile:
        soft: 32000
        hard: 40000
  artifactory:
    image: docker.bintray.io/jfrog/artifactory-oss:6.18.1
    container_name: artifactory
    hostname: {{ .ARTIFACTORY_URL }}
    ports:
      - {{ .ARTIFACTORY_PORT }}:8081    # TODO: Expose only to 127.0.0.1
    depends_on:
      - postgresql
    links:
      - postgresql
    volumes:
      - /home/vagrant/data/artifactory:/var/opt/jfrog/artifactory
    environment:
      - DB_TYPE=postgresql
      - DB_USER=artifactory
      - DB_PASSWORD=password
      # Add extra Java options by uncommenting the following line
      #- EXTRA_JAVA_OPTIONS=-Xms512m -Xmx4g
    restart: unless-stopped
    ulimits:
      nproc: 65535
      nofile:
        soft: 32000
        hard: 40000
