#!/bin/bash

# Work in home directory
cd /home/ubuntu/

# Update base packages
sudo apt update -y
sudo apt upgrade -y

# Install NginX
sudo apt install nginx -y

# Install Unzip
sudo apt install unzip -y

# Install NodeJS v20
curl -fSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt install nodejs -y

# Install PM2
sudo npm install pm2 -g

# Delete NginX default config
sudo rm -f /etc/nginx/sites-enabled/default

# Create new config for myapp
sudo tee /etc/nginx/sites-available/myapp > /dev/null <<'EOF'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:3000;
    }
}
EOF

# Create symbolic link from sites-available to sites-enabled
sudo ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/myapp

# Test NginX for debugging
sudo nginx -t

# Restart NginX to apply the configuration
sudo systemctl reload nginx

# Download .zip file from repository
curl -L https://raw.githubusercontent.com/olivermoorby64/tech613-devops-deploy-tttapp-basic/main/nodejs20-sparta-tictactoe-v1.zip -o nodejs20-sparta-tictactoe-v1.zip

# Remove previous extracted .zip file
rm -rf /home/ubuntu/app

# Extract .zip file
# If successful, delete .gitignore from .zip file
# If successful, change directory to extracted 'app' folder
unzip -q /home/ubuntu/nodejs20-sparta-tictactoe-v1.zip -d /home/ubuntu &&
rm -f /home/ubuntu/.gitignore &&
cd /home/ubuntu/app

# Install dependencies
npm ci

# Delete previous process if possible
# Then start new process
pm2 delete myapp
pm2 start index.js --name myapp