# Lord of the CLI Docker Image

[![ci.anvil.pcfdemo.com](https://ci.anvil.pcfdemo.com/api/v1/teams/pcrocker/pipelines/docker-lotc/jobs/build/badge)](https://ci.anvil.pcfdemo.com/teams/pcrocker/pipelines/docker-lotc) [docker](https://hub.docker.com/r/patrickcrocker/lotc/)

One Image to rule them all:

OS:
- ubuntu:16.04

Utils:
- bash
- curl
- wget
- [jq](https://stedolan.github.io/jq/)
- git
- xmllint (libxml2-utils)
- [yaml](https://github.com/mikefarah/yaml)

Languages:
- python (py-pip)
- ruby

CLIs:
- aws
- bosh
- [cf](https://github.com/cloudfoundry/cli)
  - [autopilot plugin](https://github.com/contraband/autopilot)
- uaac
