output "website_public_ip" {
  value = aws_instance.website.public_ip
}

output "website_public_dns" {
  value = aws_instance.website.public_dns
}
