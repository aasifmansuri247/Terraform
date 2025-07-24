#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo apt install -y docker.io
sudo docker run -d -p 5000:5000 techmypassion/python-app:latest
cat > /etc/nginx/sites-available/default <<EOL
server {
    listen 80;
    server_name www.bookdevops.shop;

    location / {
        proxy_pass http://127.0.0.1:5000;  # Flask app or backend
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOL

sudo systemctl restart nginx

sudo apt install certbot python3-certbot-nginx -y

# Automatically get certificate (domain must be pointed to EC2 public IP)
sudo certbot --nginx -d www.bookdevops.shop --non-interactive --agree-tos -m techmypassion247@gmail.com