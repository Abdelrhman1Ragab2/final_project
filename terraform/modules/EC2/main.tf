

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
resource "aws_ebs_volume" "jenkins_volume" {
  availability_zone = "eu-west-1a"
  size              = 10
  type              = "gp2"

  tags = {
    Name = "jenkins-volume"
  }
}

resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/xvdf"
  instance_id = aws_instance.jenkins-server-nti.id
  volume_id   = aws_ebs_volume.jenkins_volume.id
}

resource "aws_iam_role" "backup_role" {
  name = "aws_backup_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "backup.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup_role_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

# AWS Backup Vault
resource "aws_backup_vault" "backup_vault" {
  name        = "example-backup-vault"
  tags = {
    Name = "example-backup-vault"
  }
}

# AWS Backup Plan
resource "aws_backup_plan" "backup_plan" {
  name = "example-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.backup_vault.name
    schedule          = "cron(0 12 * * ? *)"  # Daily at 12:00 UTC
    lifecycle {
      delete_after = 35 
    }
  }
}

# AWS Backup Selection
resource "aws_backup_selection" "backup_selection" {
  name          = "example-backup-selection"
  plan_id       = aws_backup_plan.backup_plan.id
  iam_role_arn  = aws_iam_role.backup_role.arn

  resources = [
    aws_instance.jenkins-server-nti.arn,
    aws_ebs_volume.jenkins_volume.arn
  ]
}
