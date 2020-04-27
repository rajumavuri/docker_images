FROM jenkins/jnlp-slave:latest
MAINTAINER rajumavuri@gmail.com

# Sets USER to root - so I can install stuff below
USER root

RUN apt-get update
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get install -y build-essential
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys \
      409B6B1796C275462A1703113804BB82D39DC0E3 \
      7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
 && curl -sSL https://get.rvm.io | bash -s -- --autolibs=read-fail stable \
 && echo 'bundler' >> /home/docker/.rvm/gemsets/global.gems \
 && echo 'rvm_silence_path_mismatch_check_flag=1' >> ~/.rvmrc

SHELL ["/bin/bash", "-lc"]
CMD ["/bin/bash", "-l"]

ARG ruby_version=2.7.1

ENV RUBY_VERSION ${ruby_version}
# Install Rubies
RUN rvm install $RUBY_VERSION

# Set it back to USER jenkins - so we can use it as a Jenkins Slave
USER jenkins
