#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl restart apache2
name="Aniruddh"
timestamp=$(date '+%d%m%Y-%H%M%S')
s3_bucket="upgrad-aniruddh"
if [ ! -f /var/www/html/inventory.html ]; then
    sudo touch /var/www/html/inventory.html
    sudo cat "Log Type	Time Created	Type	Size" >> /var/www/html/inventory.html
fi
cd /var/log/apache2/
tar -cf /tmp/$name-httpd-logs-$timestamp.tar *.log
filename="$name-httpd-logs-$timestamp.tar"
size=`du -sh abc.tar | awk '{print $1}'`
cd ~
sudo cat "httpd-logs	$timestamp	tar	$size" >> /var/www/html/inventory.html
sudo apt update
sudo apt install awscli
aws s3 cp /tmp/$name-httpd-logs-$timestamp.tar s3://${s3_bucket}/$name-httpd-logs-$timestamp.tar
if [ ! -f /etc/cron.d/automation ]; then
    sudo touch /etc/cron.d/automation
    sudo cat "0 0 * * * root /root/Automation_Project/automation.sh" >> /etc/cron.d/automation
fi

