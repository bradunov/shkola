pwd > log.txt
sudo apt update >> log.txt
sudo apt install -y nginx >> log.txt
sudo apt install -y python3.8 >> log.txt

git clone https://github.com/bradunov/shkola.git >> log.txt
pip3 install -r requirements.txt >> log.txt

# Enable local host on port 8080 
sed 's/include \/etc\/nginx\/sites-enabled\/\*;/#include \/etc\/nginx\/sites-enabled\/\*;\nserver {\n  listen 80;\n  location \/images\/ {\n    root \/home\/azureuser\/shkola\/src\/images\/;\n  }\n  location \/ {\n    proxy_pass      http:\/\/localhost:8080;\n  }\n}/' -i /etc/nginx/nginx.conf




