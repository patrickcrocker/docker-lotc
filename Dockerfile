FROM ubuntu:16.04

RUN apt-get update && apt-get -y install \
  # Base Packages
    curl=7.47.0-1ubuntu2.2 \
    wget=1.17.1-1ubuntu1.1 \
    jq=1.5+dfsg-1 \
    vim=2:7.4.1689-3ubuntu1.2 \
    git=1:2.7.4-0ubuntu1 \
    libxml2-utils=2.9.3+dfsg1-1ubuntu0.2 \
  # AWS cli
    awscli=1.11.13-1ubuntu1~16.04.0 \
  # Ruby (for cf-uaac)
    ruby=1:2.3.0+1 \
    ruby-dev=1:2.3.0+1 \
    ruby-bundler=1.11.2-1 \
  # cf-uaac dependencies
    musl-dev=1.1.9-1 \
    gcc=4:5.3.1-1ubuntu1 \
    make=4.1-6 \
    g++=4:5.3.1-1ubuntu1 \
  && rm -rf /var/lib/apt/lists/*

# cf-uaac
RUN gem install cf-uaac -v 3.6.0 --no-ri --no-rdoc
RUN gem install json -v 2.0.3 --no-ri --no-rdoc

# Install bosh cli
RUN gem install bosh_cli -v 1.3262.26.0 --no-ri --no-rdoc

# Install Cloud Foundry cli
ADD https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.25.0 /tmp/cf-cli.tgz
RUN mkdir -p /usr/local/bin && \
  tar -xzf /tmp/cf-cli.tgz -C /usr/local/bin && \
  cf --version && \
  rm -f /tmp/cf-cli.tgz

# Install cf cli Autopilot plugin
ADD https://github.com/contraband/autopilot/releases/download/0.0.3/autopilot-linux /tmp/autopilot-linux
RUN chmod +x /tmp/autopilot-linux && \
  cf install-plugin /tmp/autopilot-linux -f && \
  rm -f /tmp/autopilot-linux

# Install Om
ADD https://github.com/pivotal-cf/om/releases/download/0.18.0/om-linux /tmp/om-linux
RUN install /tmp/om-linux /usr/local/bin/om && \
  om --version && \
  rm -f /tmp/om-linux

# Install yaml cli
ADD https://github.com/mikefarah/yaml/releases/download/1.10/yaml_linux_amd64 /tmp/yaml_linux_amd64
RUN install /tmp/yaml_linux_amd64 /usr/local/bin/yaml && \
  yaml --help && \
  rm -f /tmp/yaml_linux_amd64

# Clean apt-get cache
RUN apt-get clean
