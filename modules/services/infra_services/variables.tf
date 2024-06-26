variable "cloud_env" {
 type = string
 description = "Enter the environment (dev/qa/prod)"
}

variable "vpc_cidr" {
 type = string
 description = "Enter the VPC CIDR Value"
}

variable "vpc_tag_name" {
 type = string
 description = "Enter the VPC Tag Value"
}

variable "access_ip" {
 type = string
 default = "202.179.69.227/32"
}

variable "public_cidrs" {
 type = list(string)
 default = ["10.7.1.0/24","10.7.3.0/24"]
}

variable "private_cidrs" {
 type = list(string)
 default = ["10.7.2.0/24","10.7.4.0/24"]
}

variable "instance_type" {
 type = string
 default = "t2.micro"
}

variable "vol_size" {
 type = number
 default = 8
}

variable "instance_key_name" {
 type = string
 default = "chetan-mumbai"
}

variable "instance_count" {
 type = number
 default = 1
}

variable "bucket_name" {
 type = string
 description = "Provide name of the S3 bucket"
}

variable "region" {
 type = string
 default = "ap-south-1"
}

variable "db_instance_identifier" {
  description = "The DB instance identifier"
  type        = string
  default     = "assignment-database"
}

variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
  default     = "gp2"
}

variable "allocated_storage" {
  description = "The allocated storage for the RDS instance in GiB"
  type        = number
  default     = 20
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
  default     = "assignment-subnet-group"
}

variable "db_parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
  default     = "assignment-parameter-group"
}

variable "db_option_group_name" {
  description = "The name of the DB option group"
  type        = string
  default     = "assignment-option-group"
}

variable "db_engine" {
  description = "The database engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "The database engine version"
  type        = string
  default     = "8.0.35"
}
