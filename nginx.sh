#!/bin/bash

sudo apt install nginx -y
systemctl start nginx
systemctl enable nginx

# Prompt user for parameters
echo -n "Enter the name for the Nginx configuration file: "
read PARAM1
echo -n "Enter the port number to forward traffic: "
read PARAM2
echo -n "Enter the server names (space-separated): "
read -a SERVER_NAMES

# Create the Nginx server block file
CONFIG_PATH="/etc/nginx/sites-available/$PARAM1"

# Construct server_name string
SERVER_NAME_STRING="${SERVER_NAMES[*]}"

cat <<EOF > $CONFIG_PATH
server {
    listen 80;
    server_name $SERVER_NAME_STRING;
    location / {
        proxy_pass http://127.0.0.1:$PARAM2;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Create a symbolic link to enable the site
ln -s $CONFIG_PATH /etc/nginx/sites-enabled/

# Test Nginx configuration
nginx -t

if [ $? -eq 0 ]; then
    # Reload Nginx to apply changes
    systemctl restart nginx
    echo -e "\033[32mNginx configuration for $PARAM1 has been successfully created.\033[0m"
else
    echo -e "\033[31mNginx configuration test failed. Please check your configuration.\033[0m"
fi