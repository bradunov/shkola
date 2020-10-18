# Log is in /var/lib/waagent/custom-script/download/0
sudo apt update >> log.txt

# Install and configure nginx
sudo apt install -y nginx >> log.txt
cp nginx.conf /etc/nginx >> log.txt
sudo nginx -s reload >> log.txt

# Install python3.8
sudo apt update >> log.txt
sudo apt install -y software-properties-common >> log.txt
sudo add-apt-repository -y ppa:deadsnakes/ppa >> log.txt
sudo apt install -y python3.8 >> log.txt
sudo apt install -y python3-pip >> log.txt

git clone https://github.com/bradunov/shkola.git /home/azureuser/shkola >> log.txt
chown -R azureuser /home/azureuser/shkola >> log.txt
python3.8 -m pip install -r /home/azureuser/shkola/src/requirements.txt >> log.txt
#SHKOLA_REL_PATH=/home/azureuser/shkola python /home/azureuser/shkola/src/cherrypy/main.py

# Enable local host on port 8080 
#sed 's/include \/etc\/nginx\/sites-enabled\/\*;/#include \/etc\/nginx\/sites-enabled\/\*;\nserver {\n  listen 80;\n  location \/images\/ {\n    root \/home\/azureuser\/shkola\/src\/images\/;\n  }\n  location \/ {\n    proxy_pass      http:\/\/localhost:8080;\n  }\n}/' -i /etc/nginx/nginx.conf

# Set up systemd service
echo "AAA1: $SHKOLA_AZ_TABLE_CONN_STR" >> log.txt
echo "AAA2: $GOOGLE_CLIENT_ID" >> log.txt
echo "AAA3: $GOOGLE_SITE_VERIFICATION" >> log.txt
echo "AAA4: $SHKOLA_LA_WORKSPACE_ID" >> log.txt
echo "AAA5: $SHKOLA_LA_PRIMARY_KEY" >> log.txt
echo "AAA6: $SHKOLA_NODE_NAME" >> log.txt
cp shkola.service /lib/systemd/system/ >> log.txt
sed "s/%SHKOLA_AZ_TABLE_CONN_STR%/$SHKOLA_AZ_TABLE_CONN_STR/" -i /lib/systemd/system/shkola.service
sed "s/%GOOGLE_CLIENT_ID%/$GOOGLE_CLIENT_ID/" -i /lib/systemd/system/shkola.service
sed "s/%GOOGLE_SITE_VERIFICATION%/$GOOGLE_SITE_VERIFICATION/" -i /lib/systemd/system/shkola.service
sed "s/%SHKOLA_LA_WORKSPACE_ID%/$SHKOLA_LA_WORKSPACE_ID/" -i /lib/systemd/system/shkola.service
sed "s/%SHKOLA_LA_PRIMARY_KEY%/$SHKOLA_LA_PRIMARY_KEY/" -i /lib/systemd/system/shkola.service
sed "s/%SHKOLA_NODE_NAME%/$SHKOLA_NODE_NAME/" -i /lib/systemd/system/shkola.service
sudo systemctl daemon-reload >> log.txt
sudo systemctl enable shkola.service >> log.txt
sudo systemctl start shkola.service >> log.txt


# Check status/restart: 
#sudo systemctl status shkola.service
#sudo systemctl restart shkola.service
