output "vpc_id"{
  value= aws_vpc.nti_vpc.id
}

output "all-subnets" {
  value = [aws_subnet.nti-public_subnets[0].id,aws_subnet.nti-public_subnets[1].id,
  # aws_subnet.private_subnets[0].id,
  # aws_subnet.private_subnets[1].id
  ]
  
}


output "sg_id"{
  value= aws_security_group.sg.id
}

# output "nat-gw"{
#   value= aws_nat_gateway.ngw
# }


