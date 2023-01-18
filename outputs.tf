output "website_endpont" {
  value = module.s3.website_endpoint
}

output "website_public_ip" {
  value = module.ec2.website_public_ip
}

output "website_public_dns" {
  value = module.ec2.website_public_dns
}