#!/bin/bash
echo "Starting Script"
sudo apt-get update
sudo apt-get upgrade -y
echo "Finished updating"
sudo apt-get install curl
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash
sudo apt-get install -y nodejs
echo "Finished installing node"
git clone https://github.com/GajinKim/chat-app.git
echo "Finished cloning chat app"
cd chat-app/app/
npm i
echo "Finished installing package dependencies"
npm run build
node ./build/index.js
echo "Finished hosting app on port 3000"