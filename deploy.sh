#!/bin/bash

# Deploy Kali as a docker container. Tested on Amazon Linux 2.
# by Drew Blokzyl (@linuxkd)
# https://github.com/linuxkd/kali-docker/

sudo yum update -y
sudo yum install -y docker jq
sudo service docker start

# Create an image named kali from the specified Dockerfile
sudo docker build -t kali-image https://raw.githubusercontent.com/linuxkd/kali-docker/master/Dockerfile

# Create a container named kali based on our image also named kali
sudo docker create --name kali kali-image
sudo docker start kali

# The path where we want to easily access our /root folder for the kali container
sudo mkdir /pentest

# Get the local path on disk from the container, then soft link it for easy access
mount_path="$(sudo docker inspect kali | jq -r '.[].Mounts[0].Source')"
sudo ln -s "$mount_path" /pentest/kali-root

# Grab the wrapper script so you can get into the container by just calling "kali"
curl -s "https://raw.githubusercontent.com/linuxkd/kali-docker/master/kali" --output /tmp/kali
chmod +x /tmp/kali
sudo mv /tmp/kali /usr/local/bin
