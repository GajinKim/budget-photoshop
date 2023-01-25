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

data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "website" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.website_security_group_id]
  key_name               = "GajinsKey"
  user_data              = file("${path.module}/createwebsite.sh") # script runs whenever the EC2 Instance is launched

  disable_api_stop        = false # turn this turn TODO
  disable_api_termination = false

  # attaching storage (EBS)
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true

    tags = {
      Owner = "Gajin A"
    }
  }

  ebs_block_device {
    device_name           = "/dev/xvdb"
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true

    tags = {
      Owner = "Gajin B"
    }
  }

  tags = {
    Owner = "Gajin"
    Name  = "Basic EC2 Chat Demo App" // how you specify name of EC2 instance
  }
}

resource "aws_instance" "website_instance_1" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.website_security_group_id]
  user_data              = file("${path.module}/createwebsite_lb1.sh")

  tags = {
    Owner = "Gajin"
    Name  = "EC2 ELB Demo Instance 1"
  }
}

resource "aws_instance" "website_instance_2" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.website_security_group_id]
  user_data              = file("${path.module}/createwebsite_lb2.sh")

  tags = {
    Owner = "Gajin"
    Name  = "EC2 ELB Demo Instance 2"
  }
}

resource "aws_instance" "website_instance_3" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.website_security_group_id]
  user_data              = file("${path.module}/createwebsite_lb3.sh")

  tags = {
    Owner = "Gajin"
    Name  = "EC2 ELB Demo Instance 3"
  }
}

resource "aws_lb_target_group" "website_tg" {
  name     = "demo-website-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.website_vpc_id
}

resource "aws_lb_target_group_attachment" "website_instance_1_tg_attachment" {
  target_group_arn = aws_lb_target_group.website_tg.arn
  target_id        = aws_instance.website_instance_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "website_instance_2_tg_attachment" {
  target_group_arn = aws_lb_target_group.website_tg.arn
  target_id        = aws_instance.website_instance_2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "website_instance_3_tg_attachment" {
  target_group_arn = aws_lb_target_group.website_tg.arn
  target_id        = aws_instance.website_instance_3.id
  port             = 80
}

resource "aws_lb_listener" "website_lb_listener" {
  load_balancer_arn = aws_lb.website_application_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.website_tg.arn
  }
}

resource "aws_lb" "website_application_lb" {
  name               = "demo-website-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.website_security_group_id]
  subnets            = [aws_subnet.private1a.id, aws_subnet.private1b.id, aws_subnet.private1c.id]
}

# first 24 bits are reserved (network bits)
# remaining 8 bits are part of the host bits
resource "aws_subnet" "private1a" {
  vpc_id            = var.website_vpc_id
  cidr_block        = "172.31.200.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private1b" {
  vpc_id            = var.website_vpc_id
  cidr_block        = "172.31.201.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "private1c" {
  vpc_id            = var.website_vpc_id
  cidr_block        = "172.31.202.0/24"
  availability_zone = "us-east-1c"
}



resource "aws_autoscaling_group" "example_autoscaling_group" {
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 2

  launch_template {
    id      = aws_launch_template.example_launch_template.id
    version = "$Latest"
  }
}

// apparently AWS no longer supports aws_launch_configurations, so start using launch_template instead
# resource "aws_launch_configuration" "example_launch_configuration" {
#   name          = "example_launch_configuration"
#   image_id      = data.aws_ami.amazon-linux-2.id
#   instance_type = "t3.micro"
#   user_data     = file("${path.module}/createwebsite_lb_asg.sh")
# }

resource "aws_launch_template" "example_launch_template" {
  name          = "example_launch_template"
  image_id      = data.aws_ami.amazon-linux-2.id
  instance_type = "t3.micro"
  user_data     = filebase64("${path.module}/createwebsite_lb_asg.sh")

  # initial placement
  # placement {
  #   availability_zone = "us-east-1a"
  # }

  vpc_security_group_ids = [var.website_security_group_id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Launched from Autoscaling Group"
    }
  }
}

# how you connect the load balancer to the auto scaling group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.example_autoscaling_group.id
  lb_target_group_arn    = aws_lb_target_group.website_tg.arn
}
