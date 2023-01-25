output "website_public_ip" {
  value = format("%s/%s",aws_instance.website.public_ip,":3000")
}

output "website_public_dns" {
  value = aws_instance.website.public_dns
}

output "website_instance_1_public_ip" {
  value = aws_instance.website_instance_1.public_ip
}

output "website_instance_2_public_ip" {
  value = aws_instance.website_instance_2.public_ip
}

output "website_instance_3_public_ip" {
  value = aws_instance.website_instance_3.public_ip
}

output "website_load_balancer_dns" {
  value = aws_lb.website_application_lb.dns_name
}