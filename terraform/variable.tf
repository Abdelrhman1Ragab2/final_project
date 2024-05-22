# variable of cluster resource
variable "cluster_name" {
    type = string
    description = "name of cluster"
  
}


# variable of group node resource 
variable "group_node_name" {
    type = string
    description = "name of group-node-name"
  
}





variable "group_instance_types" {
    type = list
    description = "list of group-instance-types "
  
}

variable "group_scaling_config" {
    type = map(any)
    description = "map of scaling_config key1: desired_size  key2: max_size  key3: min_size"
  
}


# network variable
variable "vpc-cidr" {
    type = string
    description = "cidr for vpc"
  
}
variable "cidr-all" {
    type = string
    description = "cidr 0.0.0.0/0"
  
}

variable "pub-sub-cidr" {
    type = list
    description = "list of all public cidr"
  
}
# variable "priv-sub-cidr" {
#     type = list
#     description = "list of all private cidr"
  
# }
variable "availability-zone" {
    type = list
    description = "list for tow az"
  
}



# ec2.tf variable 
variable ec2-ami {
  type        = string
  description = "ami for amazon ec2 "
}

variable ec2-type {
  type        = string
  description = "type for amazon ec2"
}

variable ec2-key {
  type        = string
  description = "key for amazon ec2"
}

variable ec2-name {
  type        = string
  description = "name for amazon ec2"
}