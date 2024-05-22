# default.tf variable 
variable "db_engin" {
  type        = string
  description = "db_engin "
}

variable "db_version" {
  type        = string
  description = " db_version "
}

variable "db_class" {
  type        = string
  description = "db_class "
}

variable  "db_name" {
  type        = string
  description = "database name  "
}

# route_table.tf variable
variable "allocated_storage" {
  type        = number
  description = "allocated_storage "
}

variable "sg" {
type = list
description = "sg list"
}