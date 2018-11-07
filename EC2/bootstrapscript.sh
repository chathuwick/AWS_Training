#!/bin/bash
yum install httpd php -y
wget https://us-west-2-tcprod.s3.amazonaws.com/courses/ILT-TF-100-ARCHIT/v5.5.6/lab-2-ha/scripts/phpapp.zip
unzip phpapp.zip -d /var/www/html/
service httpd start
