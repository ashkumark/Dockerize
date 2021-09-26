

FROM jenkins/jenkins:lts
LABEL maintainer="ash"

WORKDIR /home/docker-jenkins-test
COPY src /home/docker-jenkins-test
COPY pom.xml /home/docker-jenkins-test

ENV JAVA_OPTS="-Xmx8192m"
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log"

USER root

RUN apt-get update && \
    apt-get install sudo maven -y
RUN mkdir /var/log/jenkins
RUN chown -R  jenkins:jenkins /var/log/jenkins

RUN apt-get update && \
    apt-get install -y docker-ce-cli

USER jenkins