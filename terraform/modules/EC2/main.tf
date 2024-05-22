

resource "aws_instance" "jenkins-server-nti" {
  ami = var.ec2_ami
  instance_type = var.ec2_type
  subnet_id = var.pub_ec2_sub_id
  associate_public_ip_address = true
  key_name = var.ec2_key
  
  vpc_security_group_ids = [
    var.ec2_sg
  ]

  tags = {
    Name = var.ec2_name
  }


}
