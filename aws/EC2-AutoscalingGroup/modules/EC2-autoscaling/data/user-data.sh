#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo rm /var/www/html/index.nginx-debian.html
echo "<html><head><title>Successful connection!</title></head><body><h1 style='color: blue;'>Successful connection!</h1><h2>Availability Zone: ${availability_zone}</h2></body></html>" > /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx