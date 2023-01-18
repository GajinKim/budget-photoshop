# #! /bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install nginx -y

nginx -v

# create our folders
sudo systemctl restart nginx

cd /var/www/html/
cd /

sudo systemctl reload nginx

cd /var/www/html/
# git clone https://github.com/GajinKim/conways-game-of-life.git

# just for testing
npx create-react-app react-tutorial
cd react-tutorial
npm start