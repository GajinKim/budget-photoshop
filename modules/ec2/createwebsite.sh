# #! /bin/bash

sudo apt-get update
sudo apt-get upgrade -y

# installing nginx creates our /var/www/html
sudo apt-get install nginx -y

# nginx -v
# cd /var/www/html/
# ls
# cd /

# may or may not be necessary, nginx should start up when installed
sudo systemctl reload nginx

echo "Finished installing nginx"

# install npm
sudo apt-get install curl
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash
sudo apt-get install -y nodejs

echo "Finished installing nodejs"

# node -v
# npm -v

cd /var/www/html/
sudo git clone https://github.com/GajinKim/chat-app.git

echo "Finished cloning chat app"

cd /conways-game-of-life/app
sudo npm i

echo "Finished installing package dependencies"

# build application and host the build
sudo npm run build
node ./build/index.js # https://stackoverflow.com/questions/70398935/how-to-deploy-a-svelte-kit-app-after-build-using-nginx-as-web-server/70571992

echo "Finished hosting app on nginx webserver (port 3000)"