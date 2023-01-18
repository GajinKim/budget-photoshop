output "mysql_security_group_id" {
  value = aws_security_group.mysql_security_group.id
}

output "website_security_group_id" {
  value = aws_security_group.website_security_group.id
}
