#!/bin/bash
cd /coodesh
git pull origin main
cp index.html /var/www/html
systemctl restart nginx