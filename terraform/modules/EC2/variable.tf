# ec2.tf variable 
variable ec2_ami {
  type        = string
  description = "ami for amazon ec2 "
}

variable ec2_type {
  type        = string
  description = "type for amazon ec2"
}

variable ec2_key {
  type        = string
  description = "key for amazon ec2"
}


variable ec2_sg {
  type        = string
  description = "ec2 sg  for amazon ec2"
}

variable pub_ec2_sub_id {
  type        = string
  description = "public subnet for amazon ec2"
}

variable ec2_name {
  type        = string
  description = "name for amazon ec2"
}

