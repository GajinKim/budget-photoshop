#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Instance 3 (running on us-east-1c)!</h1><br><h1>This is $(hostname -f)</h1>" > /var/www/html/index.html