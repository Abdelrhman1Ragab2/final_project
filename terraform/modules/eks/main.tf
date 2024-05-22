resource "aws_eks_cluster" "cluster" {
    
    name = var.cluster-name
    role_arn = aws_iam_role.eks_cluster_role.arn
    vpc_config {
      subnet_ids = var.cluster-subnets-id
      endpoint_public_access = var.endpoint_public
  }
      
    }

# Create IAM role for EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "my-eks-cluster-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach policy to EKS cluster role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

    


  
resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

  resource "aws_eks_node_group" "public-nodes" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = var.group-node-name
  node_role_arn = aws_iam_role.nodes.arn
  subnet_ids = var.group-subnets-id

   capacity_type  = "ON_DEMAND"
   instance_types = var.group-instance-types

   scaling_config {
    desired_size = var.group-scaling-config["desired_size"]  # return value of key == desired_size  >> 2
    max_size     = var.group-scaling-config["max_size"]
    min_size     = var.group-scaling-config["min_size"]
  }

   update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

}


