FROM jenkins/jnlp-slave:latest
MAINTAINER rajumavuri@gmail.com

# Sets USER to root - so I can install stuff below
USER root



# Install groovy

# Installs JavaScript rutime for our reporting dashboard app to run
RUN apt-get update
RUN apt-get install -y wget unzip
RUN apt-get install -y zip
#RUN apt-get install -y bundler
RUN apt-get install -y bash
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean


RUN chmod -R 777 /home


# Install SDKMAN
RUN curl -s get.sdkman.io | bash
RUN ["/bin/bash", "-c", "source $HOME/.sdkman/bin/sdkman-init.sh"]
RUN ["/bin/bash", "-c", "-l", "sdk install groovy"]


RUN chmod -R 777 /home


# Set it back to USER jenkins - so we can use it as a Jenkins Slave
USER jenkins

