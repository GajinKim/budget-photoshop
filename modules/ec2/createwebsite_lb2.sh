#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Instance 2!</h1><br><h1>This is $(hostname -f)</h1>" > /var/www/html/index.html