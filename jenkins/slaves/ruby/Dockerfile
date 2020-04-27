FROM jenkins/jnlp-slave:latest
MAINTAINER rkapuganti@lb.com

# Sets USER to root - so I can install stuff below
USER root

RUN apt-get update
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get install -y build-essential
RUN apt-get install -y ruby-full

# Set it back to USER jenkins - so we can use it as a Jenkins Slave
USER jenkins
# DOCKER IMAGE NAME - jenkins_slave:latest