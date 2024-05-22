# value of module eks 
cluster_name= "nti"
group_instance_types=["t2.medium"]
group_node_name ="nti-node"
group_scaling_config ={
    desired_size=2
    max_size=4
    min_size=1
}

# variable module network1
vpc-cidr ="10.1.0.0/16"
cidr-all ="0.0.0.0/0"
pub-sub-cidr =[   
"10.1.1.0/24",
"10.1.2.0/24",
]


availability-zone =[   
"eu-west-1a",
"eu-west-1b",
]
# ec2 var
ec2-ami= "ami-0776c814353b4814d"
ec2-type= "t2.micro"
ec2-key= "key1"
ec2-name = "jenkins-server-nti"
