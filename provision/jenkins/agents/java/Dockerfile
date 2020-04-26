FROM alpine:3.9.6

ENV JAVA_HOME /usr/lib/jvm/default-jvm

RUN apk add --no-cache openjdk8 && \
    ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/" && \
    apk add --no-cache git && \
    apk add --no-cache bash && \
    adduser -D jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2 && \
    chown -R jenkins:jenkins /home/jenkins/.m2/

#RUN MAVEN_VERSION=3.3.9 \
# && cd /usr/share \
# && wget -q http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O - | tar xzf - \
# && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
# && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
#ENV MAVEN_HOME /usr/share/maven

RUN apk add --no-cache openssh && \
    mkdir -p /var/run/sshd && \
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
    ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
