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

data "template_file" "script" {
  template = file("userdata.sh")
  vars = {
    efs-id = aws_efs_file_system.data.dns_name
  }
}

resource "aws_launch_template" "this" {
    name_prefix = "lt-"
    image_id = data.aws_ami.ubuntu.id
    instance_type = var.ec2_instance_type
    key_name = var.key_name
    monitoring {
      enabled = false
    }
    network_interfaces {
      associate_public_ip_address = true
      delete_on_termination = true
      security_groups = [aws_security_group.sg_ec2.id]
    }
}

resource "aws_autoscaling_group" "this" {
  name                      = "${var.project-name}-as"
  min_size                  = 0
  desired_capacity          = 0
  max_size                  = 0
  force_delete              = true
  health_check_grace_period = 240
  health_check_type         = "ELB"
  target_group_arns         = [aws_lb_target_group.this.id]
  vpc_zone_identifier       = [aws_subnet.public01.id, aws_subnet.public02.id, aws_subnet.public03.id]

  launch_template {
    id = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.project-name}-instance"
    propagate_at_launch = true
  }
}

resource "aws_instance" "glpi" {
  instance_type               = var.ec2_instance_type
  ami                         = data.aws_ami.ubuntu.id
  vpc_security_group_ids      = [aws_security_group.sg_ec2.id]
  subnet_id                   = aws_subnet.public01.id
  user_data                   = data.template_file.script.rendered
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags = {
    Name = "glpi"
  }
}