#!/bin/bash

# https://podman.io/docs/installation

sudo apt-get update -y

sudo apt-get -y install podman

podman --version

# podman info

# Installazione di uidmap
# sudo apt install -y uidmap

# Configurazione dei subuid e subgid
# echo "$USER:100000:65536" | sudo tee -a /etc/subuid
# echo "$USER:100000:65536" | sudo tee -a /etc/subgid
 
sudo tee -a /etc/containers/registries.conf <<EOF
unqualified-search-registries = ["docker.io"]

[[registry]]
location = "docker.io"
insecure = false
EOF


cat /etc/containers/storage.conf