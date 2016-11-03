FROM alpine:3.4

# Install base packages
RUN apk update
RUN apk upgrade
RUN apk add bash curl wget tar jq openssh util-linux

# Install python
RUN apk add py-pip

# Install aws cli
RUN pip install awscli

# Install ruby
RUN apk add ruby ruby-dev ruby-bundler

# Install cf-uaac
RUN apk add musl-dev gcc make g++
RUN gem install cf-uaac -v 3.4.0 --no-rdoc --no-ri
RUN gem install json --no-rdoc --no-ri

# Install bosh cli
RUN gem install bosh_cli --no-ri --no-rdoc

# Install Cloud Foundry cli
ADD https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.22.2 /tmp/cf-cli.tgz
RUN mkdir -p /usr/local/bin && \
    tar -xzf /tmp/cf-cli.tgz -C /usr/local/bin && \
    cf --version
RUN rm -f /tmp/cf-cli.tgz

# Clean apk cache
RUN rm -rf /var/cache/apk/*
