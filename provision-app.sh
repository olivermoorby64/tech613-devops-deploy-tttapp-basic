#!/bin/bash

cd /home/ubuntu/

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}====="
echo -e "Updating base packages..."
echo -e "=====${NC}"

sudo apt update -y
sudo apt upgrade -y

echo -e "${GREEN}====="
echo -e "Finished base package updates!"
echo -e "=====${NC}"

echo -e "${YELLOW}====="
echo -e "Installing NginX..."
echo -e "=====${NC}"

sudo apt install nginx -y

echo -e "${GREEN}====="
echo -e "Finished installing NginX!"
echo -e "=====${NC}"

echo -e "${YELLOW}====="
echo -e "Installing Unzip..."
echo -e "=====${NC}"

sudo apt install unzip -y

echo -e "${GREEN}====="
echo -e "Finished installing Unzip!"
echo -e "=====${NC}"

echo -e "${YELLOW}====="
echo -e "Installing NodeJS v20..."
echo -e "=====${NC}"

curl -fSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt install nodejs -y

echo -e "${GREEN}====="
echo -e "Finished installing NodeJS!"
echo -e "=====${NC}"

echo -e "${YELLOW}====="
echo -e "Installing PM2..."
echo -e "=====${NC}"

sudo npm install pm2 -g

echo -e "${GREEN}====="
echo -e "Finished installing PM2!"
echo -e "=====${NC}"

echo -e "${YELLOW}====="
echo -e "Starting the TTTApp..."
echo -e "=====${NC}"

rm -f .gitignore
rm -rf /home/ubuntu/app

unzip -q /home/ubuntu/nodejs20-sparta-tictactoe-v1.zip -d /home/ubuntu

cd /home/ubuntu/app

npm ci

pm2 delete myapp
pm2 start index.js --name myapp

echo -e "${GREEN}====="
echo -e "App is running!"
echo -e "=====${NC}"