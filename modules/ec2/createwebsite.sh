#!/bin/bash
echo "Starting Script"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo systemctl reload nginx
echo "Finished installing nginx"
sudo apt-get install curl
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash
sudo apt-get install -y nodejs
cd /var/www/html/
sudo git clone https://github.com/GajinKim/chat-app.git
echo "Finished cloning chat app"
cd /chat-app/app
sudo npm i
echo "Finished installing package dependencies"
sudo npm run build
node ./build/index.js
echo "Finished hosting app on nginx webserver (port 3000)"