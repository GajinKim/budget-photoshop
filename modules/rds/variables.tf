# variable "rds_password" {
#         type = string
#         description = "Password to login to RDS instance"
#         sensitive = true
# }

variable "mysql_security_group_id" {
        type = string
        description = "MySQL security group id"
}