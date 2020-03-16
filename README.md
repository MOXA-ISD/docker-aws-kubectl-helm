# Docker alpine with awscli, kubectl and helm

Like it says, it's a docker image built on alpine with awscli, kubectl and helm installed. Size 72.31 MB.

Available from docker hub as [thingsprosre/awscli-kubectl-helm](https://hub.docker.com/r/thingsprosre/awscli-kubectl-helm/)

## Usage

    docker run -it --rm thingsprosre/awscli-kubectl-helm bash

## Development

### Clone

```bash
git clone git@github.com:MOXA-ISD/docker-awscli-kubectl-helm.git
```

### Modify config

You can modify or update tools version in config.ini before build image

### Instruction

```bash
# build image
make build

# publish image
make publish
```