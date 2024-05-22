resource "aws_db_instance" "my_rds_instance" {
  engine              = var.db_engin 
  engine_version      = var.db_version 
  instance_class     = var.db_class 
  db_name              = var.db_name 
  username            = aws_secretsmanager_secret_version.rds_username.secret_string
  password            = aws_secretsmanager_secret_version.rds_password.secret_string
  allocated_storage   = var. allocated_storage 
  vpc_security_group_ids = var.sg
}

# Create Secrets Manager secrets for RDS username and password
resource "aws_secretsmanager_secret" "rds_username" {
  name = "rds-username"
}

resource "aws_secretsmanager_secret_version" "rds_username" {
  secret_id     = aws_secretsmanager_secret.rds_username.id
  secret_string = "mydbuser"
}

resource "aws_secretsmanager_secret" "rds_password" {
  name = "rds-password"
}

resource "aws_secretsmanager_secret_version" "rds_password" {
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = "mydbpassword"
}
