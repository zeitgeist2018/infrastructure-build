
# 2 If you want to install Artifactory without docker:

sudo apt-get -y install zip openjdk-8-jre-headless

VERSION=6.18.1
wget https://bintray.com/jfrog/artifactory/download_file?file_path=jfrog-artifactory-oss-${VERSION}.zip -O artifactory.zip
unzip artifactory.zip
sudo mv artifactory-oss-${VERSION} /opt/artifactory
sudo /opt/artifactory/bin/installService.sh
sudo service artifactory start

# 3 If you want to install Artifactory with docker:

# sudo docker run --name artifactory -d -p 8081:8081 docker.bintray.io/jfrog/artifactory-oss:latest