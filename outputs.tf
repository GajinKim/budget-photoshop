output "website_endpont" {
  value = module.s3.website_endpoint
}

output "website_public_ip" {
  value = module.ec2.website_public_ip
}

output "website_public_dns" {
  value = module.ec2.website_public_dns
}
output "website_instance_1_public_ip" {
  value = module.ec2.website_instance_1_public_ip
}

output "website_instance_2_public_ip" {
  value = module.ec2.website_instance_2_public_ip
}

output "website_instance_3_public_ip" {
  value = module.ec2.website_instance_3_public_ip
}

output "website_load_balancer_dns" {
  value = module.ec2.website_load_balancer_dns
}