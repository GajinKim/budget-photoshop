#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Instance 1 (running on us-east-1a)!</h1><br><h1>This is $(hostname -f)</h1>" > /var/www/html/index.html