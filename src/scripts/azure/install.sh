#!/bin/bash

# Log is in /var/lib/waagent/custom-script/download/0
sudo apt update >> log.txt

# Install and configure nginx
sudo apt install -y nginx >> log.txt
cp nginx.conf /etc/nginx >> log.txt
sudo nginx -s reload >> log.txt

# Install CPU perf monitor
sudo apt install -y sysstat >> log.txt

# Instal certbot to autogenerate SSL keys: 
# https://certbot.eff.org/lets-encrypt/ubuntubionic-nginx
sudo snap install core >> log.txt
sudo snap refresh core >> log.txt
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# Install python3.8
sudo apt update >> log.txt
sudo apt install -y software-properties-common >> log.txt
sudo add-apt-repository -y ppa:deadsnakes/ppa >> log.txt
sudo apt install -y python3.8 >> log.txt
sudo apt install -y python3-pip >> log.txt

git clone https://github.com/bradunov/shkola.git /home/azureuser/shkola >> log.txt
chown -R azureuser /home/azureuser/shkola >> log.txt
runuser -l azureuser -c "python3.8 -m pip install -r /home/azureuser/shkola/src/requirements.txt" >> log.txt
#SHKOLA_REL_PATH=/home/azureuser/shkola python /home/azureuser/shkola/src/cherrypy/main.py

# Enable local host on port 8080 
#sed 's/include \/etc\/nginx\/sites-enabled\/\*;/#include \/etc\/nginx\/sites-enabled\/\*;\nserver {\n  listen 80;\n  location \/images\/ {\n    root \/home\/azureuser\/shkola\/src\/images\/;\n  }\n  location \/ {\n    proxy_pass      http:\/\/localhost:8080;\n  }\n}/' -i /etc/nginx/nginx.conf


# Argument processing as explained here: 
# http://blog.turtlesystems.co.uk/2018/11/25/Passing-Mutliple-Arguments-to-Custom-Script-in-an-ARM-Template/
sudo apt-get install -y jq
# Get the base64 encoded string
BASE64_ENCODED=$1

# Decode the encoded string into a JSON string
echo $BASE64_ENCODED | base64 --decode | jq . > args.json

# Read the args file in and set the script variables
VARS=( `cat args.json | jq -r '. | keys[] as $k | "\($k)=\"\(.[$k])\""'` )

# Evaluate all the vars
for VAR in "${VARS[@]}"
do
    eval "export $VAR"
done


# Set up shkola systemd service
cp shkola.service /lib/systemd/system/ >> log.txt
sed "s#%SHKOLA_AZ_TABLE_CONN_STR%#$SHKOLA_AZ_TABLE_CONN_STR#" -i /lib/systemd/system/shkola.service
sed "s#%GOOGLE_CLIENT_ID%#$GOOGLE_CLIENT_ID#" -i /lib/systemd/system/shkola.service
sed "s#%GOOGLE_SITE_VERIFICATION%#$GOOGLE_SITE_VERIFICATION#" -i /lib/systemd/system/shkola.service
sed "s#%GOOGLE_TAG_MANAGER%#$GOOGLE_TAG_MANAGER#" -i /lib/systemd/system/shkola.service
sed "s#%SHKOLA_LA_WORKSPACE_ID%#$SHKOLA_LA_WORKSPACE_ID#" -i /lib/systemd/system/shkola.service
sed "s#%SHKOLA_LA_PRIMARY_KEY%#$SHKOLA_LA_PRIMARY_KEY#" -i /lib/systemd/system/shkola.service
sed "s#%SHKOLA_NODE_NAME%#$SHKOLA_NODE_NAME#" -i /lib/systemd/system/shkola.service
sudo systemctl daemon-reload >> log.txt
sudo systemctl enable shkola.service >> log.txt
sudo systemctl start shkola.service >> log.txt


# Set up vm_status systemd service
cp vm_status.service /lib/systemd/system/ >> log.txt
sed "s#%SHKOLA_AZ_TABLE_CONN_STR%#$SHKOLA_AZ_TABLE_CONN_STR#" -i /lib/systemd/system/vm_status.service
sed "s#%GOOGLE_CLIENT_ID%#$GOOGLE_CLIENT_ID#" -i /lib/systemd/system/vm_status.service
sed "s#%GOOGLE_SITE_VERIFICATION%#$GOOGLE_SITE_VERIFICATION#" -i /lib/systemd/system/vm_status.service
sed "s#%GOOGLE_TAG_MANAGER%#$GOOGLE_TAG_MANAGER#" -i /lib/systemd/system/vm_status.service
sed "s#%SHKOLA_LA_WORKSPACE_ID%#$SHKOLA_LA_WORKSPACE_ID#" -i /lib/systemd/system/vm_status.service
sed "s#%SHKOLA_LA_PRIMARY_KEY%#$SHKOLA_LA_PRIMARY_KEY#" -i /lib/systemd/system/vm_status.service
sed "s#%SHKOLA_NODE_NAME%#$SHKOLA_NODE_NAME#" -i /lib/systemd/system/vm_status.service
sudo systemctl daemon-reload >> log.txt
sudo systemctl enable vm_status.service >> log.txt
sudo systemctl start vm_status.service >> log.txt



# Check status/restart: 
#sudo systemctl status shkola.service
#sudo systemctl restart shkola.service
