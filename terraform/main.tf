


module "nti-cluster" {
    source = "./modules/eks"  
   cluster-name = var.cluster_name   
   cluster-subnets-id = module.nti-network.all-subnets
   group-instance-types = var.group_instance_types
   group-node-name = var.group_node_name 
   endpoint_public = true

 
   group-subnets-id = [
    module.nti-network.all-subnets[0],
    module.nti-network.all-subnets[1]
   ]
   group-scaling-config = var.group_scaling_config 
   cluster-vpc-id = module.nti-network.vpc_id

}

module "nti-network" {

    source = "./modules/network"
     vpc_cidr = var.vpc-cidr
    pub_sub_cidr= var.pub-sub-cidr
    availability_zone=var.availability-zone
    cidr_all=var.cidr-all
}

# module "nti-rds" {

#     source = "./modules/RDS"
#     db_name = "ntiData" # the same value in index.js 
#     db_engin = "postgres"
#     db_version =  "15.6"
#     db_class =  "db.t3.small"
#     allocated_storage = 20
#     sg = [module.nti-network.sg_id]


# }

module "nti-ec2" {

    source = "./modules/EC2"
    ec2_ami= var.ec2-ami
    ec2_key=var.ec2-key
    pub_ec2_sub_id= module.nti-network.all-subnets[0]
    ec2_sg=module.nti-network.sg_id
    ec2_name= var.ec2-name
    ec2_type=var.ec2-type

}

resource "aws_ecr_repository" "my_ecr_repository" {
  name                 = "my-ecr-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


