# Docker Ansible

This repository contains a Dockerfile to create a Docker image for running Ansible. The image is based on Ubuntu 22.04 and includes specific versions of Ansible Core, Ansible, and Ansible Lint.

## Features

- **Base Image**: Ubuntu 22.04
- **Ansible Versions**:
  - Ansible Core: 2.17.0
  - Ansible: 10.0.1
  - Ansible Lint: 24.6.0

## Usage

### Build the docker image

To build the Docker image, clone this repository and run:

```bash
docker build -t arxlab/docker-ansible .
```

### Runing the docker container

To run the Docker container, use:

```bash
docker run -it arxlab/docker-ansible /bin/sh
```

To run the container and mount local directory and ssh key, use:

```bash
docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa arxlab/ansible:latest /bin/sh
```

To run the container and inject a playbook, use:

```bash
docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa arxlab/ansible:latest ansible-playbook playbook.yml
```
