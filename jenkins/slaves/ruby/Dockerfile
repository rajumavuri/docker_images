FROM jenkins/jnlp-slave:latest
MAINTAINER rajumavuri@gmail.com

USER root

RUN apt-get update
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get install -y build-essential
RUN apt-get install -y ruby-full

USER jenkins
