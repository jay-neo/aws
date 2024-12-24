#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y

sudo apt install git -y

sudo apt install curl -y

# curl -L https://www.npmjs.com/install.sh | bash
# source ~/.bashrc
# nvm install node

sudo apt install npm -y
source ~/.bashrc

npm i -g pm2
