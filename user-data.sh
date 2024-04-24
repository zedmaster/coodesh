#!/bin/bash
apt-get update -y
apt-get install -y nginx ruby git
git config --global user.name "ubuntu"
git config --global user.email "ubuntu@email.com"
git clone https://github.com/zedmaster/coodesh.git
cp /coodesh/index.html /var/www/html/
service nginx restart
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
chmod +x install
./install auto
service codedeploy-agent status