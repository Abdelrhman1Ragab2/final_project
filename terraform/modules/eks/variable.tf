# variable of cluster resource
variable "cluster-name" {
    type = string
    description = "name of cluster"
  
}



variable "cluster-subnets-id" {
    type = list
    description = "list of subnets in cluster"
  
}

# variable of group node resource 
variable "group-node-name" {
    type = string
    description = "name of group-node-name"
  
}

variable "endpoint_public" {
    type = bool
    description = "endpoint_public of cluster "
  
}

variable "group-subnets-id" {
    type = list
    description = "list of subnets in group node"
  
}

variable "group-instance-types" {
    type = list
    description = "list of group-instance-types "
  
}

variable "group-scaling-config" {
    type = map(any)
    description = "map of scaling_config key1: desired_size  key2: max_size  key3: min_size"
  
}


variable "cluster-vpc-id" {
    type = string
    description = "cluster-vpc-id"
  
}
