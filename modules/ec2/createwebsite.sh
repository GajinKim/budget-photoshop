# #! /bin/bash

sudo apt-get update
sudo apt-get upgrade -y

# installing nginx creates our /var/www/html
sudo apt-get install nginx -y

# nginx -v
# cd /var/www/html/
# ls
cd /

sudo systemctl reload nginx

# install npm
sudo apt-get install curl
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash
sudo apt-get install -y nodejs

# node -v
# npm -v

cd /var/www/html/
git clone https://github.com/GajinKim/chat-app.git
cd /conways-game-of-life/app
sudo npm i
node ./build/index.js # https://stackoverflow.com/questions/70398935/how-to-deploy-a-svelte-kit-app-after-build-using-nginx-as-web-server/70571992