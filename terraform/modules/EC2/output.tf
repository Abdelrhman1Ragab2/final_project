output "ec2-ip" {
  description = "The ip addreses for ec2"
  value       = aws_instance.jenkins-server-nti.public_ip
}
