variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = ""
  default     = "default"
}

variable "project-name" {
  type        = string
  description = ""
  default     = "glpi"

}

variable "ec2_instance_type" {
  type        = string
  description = ""
  default     = "t2.micro"
}

variable "db_instance_type" {
  type        = string
  description = ""
  default     = "db.t2.micro"
}

variable "key_name" {
  type        = string
  description = ""
  default     = "aws01"
}