FROM ubuntu:16.04

# Install base packages
RUN apt-get update
RUN apt-get -y install curl=7.47.0-1ubuntu2.2
RUN apt-get -y install wget=1.17.1-1ubuntu1.1
RUN apt-get -y install jq=1.5+dfsg-1

# Install aws cli
RUN apt-get -y install awscli=1.11.13-1ubuntu1~16.04.0

# Install ruby
RUN apt-get -y install ruby=1:2.3.0+1 ruby-dev=1:2.3.0+1 ruby-bundler=1.11.2-1

# Install cf-uaac
RUN apt-get -y install musl-dev=1.1.9-1
RUN apt-get -y install gcc=4:5.3.1-1ubuntu1
RUN apt-get -y install make=4.1-6
RUN apt-get -y install g++=4:5.3.1-1ubuntu1
RUN gem install cf-uaac -v 3.6.0 --no-ri --no-rdoc
RUN gem install json -v 2.0.3 --no-ri --no-rdoc

# Install bosh cli
RUN gem install bosh_cli -v 1.3262.26.0 --no-ri --no-rdoc

# Install Cloud Foundry cli
ADD https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.24.0 /tmp/cf-cli.tgz
RUN mkdir -p /usr/local/bin && \
  tar -xzf /tmp/cf-cli.tgz -C /usr/local/bin && \
  cf --version
RUN rm -f /tmp/cf-cli.tgz

# Install Om
Add https://github.com/pivotal-cf/om/releases/download/0.18.0/om-linux /tmp/om-linux
RUN install /tmp/om-linux /usr/local/bin/om && \
  om --version
RUN rm -f /tmp/om-linux

# Clean apt-get cache
RUN apt-get clean
