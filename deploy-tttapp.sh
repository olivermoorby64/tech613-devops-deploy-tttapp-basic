#!/bin/bash

cd /home/ubuntu/

GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}====="
echo -e "Updating base packages..."
echo -e "=====${NC}"

sudo apt update -y
sudo apt upgrade -y

echo -e "${GREEN}====="
echo -e "Finished base package updates!"
echo -e "=====${NC}"

echo -e "${GREEN}====="
echo -e "Installing NginX..."
echo -e "=====${NC}"

sudo apt install nginx -y

echo -e "${GREEN}====="
echo -e "Finished installing NginX!"
echo -e "=====${NC}"

echo -e "${GREEN}====="
echo -e "Installing NodeJS v20..."
echo -e "=====${NC}"

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt install nodejs -y

echo -e "${GREEN}====="
echo -e "Finished installing NodeJS!"
echo -e "=====${NC}"

echo -e "${GREEN}====="
echo -e "Starting the TTTApp..."
echo -e "=====${NC}"

cd app
npm install
npm start &

echo -e "${GREEN}====="
echo -e "App is running!"
echo -e "Use the following command to kill it: ps aux | grep -E 'npm start|node' | grep -v grep"
echo -e "=====${NC}"