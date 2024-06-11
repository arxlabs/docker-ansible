FROM ubuntu:22.04

ENV ANSIBLE_CORE_VERSION="2.17.0"
ENV ANSIBLE_VERSION="10.0.1"
ENV ANSIBLE_LINT_VERSION="24.6.0"

# Labels.
LABEL org.opencontainers.image.authors="arxlabs.eu@gmail.com"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="arxlab/docker-ansible"
LABEL org.label-schema.description="Ansible in Docker"
LABEL org.label-schema.url="https://github.com/arxlabs/docker-ansible"
LABEL org.label-schema.vcs-url="hhttps://github.com/arxlabs/docker-ansible"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vendor="Arx Labs"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa arxlab/ansible:latest"

# INstall required dependencies for Ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y python3-pip openssh-client sshpass gnupg2 git  && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Install Ansible
RUN python3 -m pip install --upgrade pip cffi && \
    pip3 install ansible-core==${ANSIBLE_CORE_VERSION} && \
    pip3 install ansible==${ANSIBLE_VERSION} ansible-lint==${ANSIBLE_LINT} && \
    rm -rf /root/.cache/pip

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

WORKDIR /ansible

CMD [ "ansible-playbook", "--version" ]