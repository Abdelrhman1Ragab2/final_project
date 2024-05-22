
#vpc
resource "aws_vpc" "nti_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "nti-vpc-20"
  }
}

#pub-subnets
resource "aws_subnet" "nti-public_subnets" {
   count=length(var.pub_sub_cidr)
   map_public_ip_on_launch = true
  vpc_id     = aws_vpc.nti_vpc.id
  cidr_block = var.pub_sub_cidr[count.index]  #["10.0.1.0/24","10.0.2.0/24"]
  availability_zone= var.availability_zone[count.index]    #["eu-west-1a","eu-west-1b"]
  
  tags = {
    Name = "nti-pub-subnet${count.index}"
  }
}

# # priv-subnets
# resource "aws_subnet" "private_subnets" {
#   count= length(var.priv_sub_cidr) 
#   vpc_id     = aws_vpc.nti_vpc.id
#   cidr_block = var.priv_sub_cidr[count.index]
#   availability_zone= var.availability_zone[count.index]

#   tags = {
#     Name = "priv-subnet${count.index}"
#   }
# }


# Create a internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nti_vpc.id

  tags = {
    Name = "nti-igw-20"
  }
}

# # Create a NAT gateway
# resource "aws_nat_gateway" "ngw" {
#   allocation_id = aws_eip.eip.id
#   subnet_id     = aws_subnet.public_subnets[0].id
# }

# # Create an Elastic IP for the NAT gateway
# resource "aws_eip" "eip" {
#   domain = "vpc"
# }


#route table public
resource "aws_route_table" "pub-route-tables" {
  vpc_id = aws_vpc.nti_vpc.id

  route {
    cidr_block = var.cidr_all
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route-public-table-20 "
  }
}

# #route table private
# resource "aws_route_table" "priv-route-tables" {
#   vpc_id = aws_vpc.nti_vpc.id

#   route {
#     cidr_block = var.cidr_all
#     nat_gateway_id = aws_nat_gateway.ngw.id
#   }

#   tags = {
#     Name = "route-private-table"
#   }
# }


resource "aws_route_table_association" "route-table-association-subnet-igw" {
  count=2
  subnet_id      = aws_subnet.nti-public_subnets[count.index].id
  route_table_id = aws_route_table.pub-route-tables.id
}

# resource "aws_route_table_association" "route-table-association-subnet-ngw" {
#   count=2
#   subnet_id      = aws_subnet.private_subnets[count.index].id
#   route_table_id = aws_route_table.priv-route-tables.id
# }


resource "aws_security_group" "sg" {
  name        = "snti-ecurity-group"
  description = "Security group allowing http traffic"
  vpc_id      = aws_vpc.nti_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_all] // Allows HTTP from any IPv4 address
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_all]
  }
  tags = {
    Name = "nti-sg-20"
  }
}