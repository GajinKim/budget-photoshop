resource "aws_security_group" "mysql_security_group" {
  name        = "mysql_security_group"
  description = "Allow MySQL inbound traffic"

  # SAI IP
  ingress {
    description = "MySQL Ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["209.201.33.148/32"]
  }

  # wildcard
  ingress {
    description = "MySQL Ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
