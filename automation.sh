#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl restart apache2
name="Aniruddh"
timestamp=$(date '+%d%m%Y-%H%M%S')
s3_bucket="upgrad-aniruddh"
cd /var/log/apache2/
tar -cf /tmp/$name-httpd-logs-$timestamp.tar *.log
cd ~
sudo apt update
sudo apt install awscli
aws s3 cp /tmp/$name-httpd-logs-$timestamp.tar s3://${s3_bucket}/$name-httpd-logs-$timestamp.tar

