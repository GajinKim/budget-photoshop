data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# resource "tls_private_key" "website_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "website_key_pair" {
#   key_name   = "GajinsWebsiteKey"
#   public_key = tls_private_key.website_key.public_key_openssh
# }

resource "aws_instance" "website" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.website_security_group_id]
  key_name               = "GajinsKey"
  user_data              = file("${path.module}/createwebsite.sh") # script runs whenever the EC2 Instance is launched

  # attaching storage (EBS)
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true

    tags = {
      Owner = "Gajin"
    }
  }

  tags = {
    Owner = "Gajin"
    Name  = "Gajins EC2 Conways Game of Life Website" // how you specify name of EC2 instance
  }
}
