data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "website" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.website_security_group_id]
  user_data              = file("${path.module}//createwebsite.sh") # script runs whenever the EC2 Instance is launched

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
