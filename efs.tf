resource "aws_efs_file_system" "data" {
  encrypted        = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  tags = {
    Name = "${var.project-name}-arquivos"
  }
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }
}

resource "aws_efs_mount_target" "data-mount_1a" {
  file_system_id  = aws_efs_file_system.data.id
  subnet_id       = aws_subnet.private01.id
  security_groups = [aws_security_group.sg_efs.id]
}

resource "aws_efs_mount_target" "data-mount_1b" {
  file_system_id  = aws_efs_file_system.data.id
  subnet_id       = aws_subnet.private02.id
  security_groups = [aws_security_group.sg_efs.id]
}

resource "aws_efs_mount_target" "data-mount_1c" {
  file_system_id  = aws_efs_file_system.data.id
  subnet_id       = aws_subnet.private03.id
  security_groups = [aws_security_group.sg_efs.id]
}

resource "aws_efs_access_point" "efs-data" {
  file_system_id = aws_efs_file_system.data.id
  root_directory {
    path = "/"
  }
}