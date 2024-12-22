#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y

sudo apt install -y git

sudo apt install curl

# curl -L https://www.npmjs.com/install.sh | bash
# source ~/.bashrc
# nvm install node

sudo apt install npm
source ~/.bashrc

npm i -g pm2
