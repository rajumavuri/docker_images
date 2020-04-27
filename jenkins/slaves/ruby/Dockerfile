FROM jenkins/jnlp-slave:latest
MAINTAINER rajumavuri@gmail.com

# Sets USER to root - so I can install stuff below
USER root

RUN apt-get update \
 && apt-get install -y \
      autoconf \
      automake \
      bison \
      gawk \
      make \
      libbz2-dev \
      libcurl4-openssl-dev \
      libevent-dev \
      libffi-dev \
      libgdbm-dev \
      libglib2.0-dev \
      libncurses-dev \
      libpq-dev \
      libreadline-dev \
      libsqlite3-dev \
      libssl-dev \
      libxml2-dev \
      libxslt-dev \
      libyaml-dev \
      zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app && chown jenkins /usr/src/app

USER jenkins

# Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys \
      409B6B1796C275462A1703113804BB82D39DC0E3 \
      7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
 && curl -sSL https://get.rvm.io | bash -s -- --autolibs=read-fail stable \
 && echo 'bundler' >> /home/jenkins/.rvm/gemsets/global.gems \
 && echo 'rvm_silence_path_mismatch_check_flag=1' >> ~/.rvmrc

EVN RUBY_VERSION

CMD ["rvm", "install", "$RUBY_VERSION"]

# Set it back to USER jenkins - so we can use it as a Jenkins Slave

