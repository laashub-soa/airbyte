#!/usr/bin/env bash

set -ex

install_init() {
  sudo yum update -y
}

install_docker() {
  sudo yum install -y docker
  sudo service docker start
  sudo usermod -a -G docker ec2-user
}

install_docker_compose() {
  sudo wget "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -O /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
}

install_airbyte() {
  mkdir airbyte && cd airbyte
  wget https://raw.githubusercontent.com/airbytehq/airbyte/master/{.env,docker-compose.yaml}
  docker-compose up -d
}

main() {
  install_init
  install_docker
  install_docker_compose
  install_airbyte
}

main > /tmp/init.log 2>&1
