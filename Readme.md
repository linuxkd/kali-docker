# What is this?
This repository contains a set of scripts and configuration files 
to quickly deploy Kali Linux in a docker container with a reasonable 
set of tools installed.

# Why do this?
From time to time we run into scenarios where a client must utilize a 
standard image for all deployments. This allows for the deployment of 
a Docker container with all of the needed tools while adhering to their 
standard.

# Installation
A simple on liner will perform all of the needed actions. I recommend 
cloning this repository to a location that you control so there are 
no unexpected changes in the future if you depend on any of this 
functionality.

```curl -s "https://raw.githubusercontent.com/linuxkd/kali-docker/master/deploy.sh" | sudo bash -```

