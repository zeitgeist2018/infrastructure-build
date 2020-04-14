FROM jenkins/jenkins:2.230

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY config /var/jenkins_home
COPY jobs /usr/share/jenkins/ref/jobs

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
