resource "aws_vpc" "assignment_vpc" {
  cidr_block  = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name = "${var.cloud_env}-${var.vpc_tag_name}"
  }
  
  lifecycle {
   create_before_destroy = true
  }
}

resource "aws_internet_gateway" "assignment_internet_gateway" {
 vpc_id = aws_vpc.assignment_vpc.id
 
 tags = {
  Name = "${var.cloud_env}_assignment_internet_gateway"
 }
}

resource "aws_default_route_table" "assignment_private_rt" {
 default_route_table_id = aws_vpc.assignment_vpc.default_route_table_id
 
 tags = {
  Name = "${var.cloud_env}_assignment_default_private_rt"
 }
}

resource "aws_route_table" "assignment_public_rt" {
 vpc_id = aws_vpc.assignment_vpc.id
 
 tags = {
  Name = "${var.cloud_env}_assignment_public_route_table"
 }
}

resource "aws_route" "assignment_test_route" {
 route_table_id = aws_route_table.assignment_public_rt.id
 destination_cidr_block = "0.0.0.0/0"
 gateway_id = aws_internet_gateway.assignment_internet_gateway.id
}

resource "aws_security_group" "ec2_sg" {
 name = "${var.cloud_env}_ec2_sg"
 description = "security group for public instances"
 vpc_id = aws_vpc.assignment_vpc.id
}

resource "aws_security_group_rule" "ingress_ssh_ec2" {
 type = "ingress"
 from_port = 22
 to_port = 22
 protocol = "tcp"
 cidr_blocks = [var.access_ip]
 security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "egress_all_ec2" {
 type = "egress"
 from_port = 0
 to_port = 65535
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group" "rds_sg" {
 name = "${var.cloud_env}_rds_sg"
 description = "security group for RDS"
 vpc_id = aws_vpc.assignment_vpc.id
}

resource "aws_security_group_rule" "ingress_rds" {
 type = "ingress"
 from_port = 3306
 to_port = 3306
 protocol = "tcp"
 cidr_blocks = ["${data.aws_instance.assignment_ec2.private_ip}/32"]
 security_group_id = aws_security_group.rds_sg.id
}

resource "aws_security_group_rule" "egress_all_rds" {
 type = "egress"
 from_port = 0
 to_port = 65535
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 security_group_id = aws_security_group.rds_sg.id
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "assignment_public_test_subnet" {
 count = 2
 vpc_id = aws_vpc.assignment_vpc.id
 cidr_block = var.public_cidrs[count.index]
 map_public_ip_on_launch = true
 availability_zone = data.aws_availability_zones.available.names[count.index]
 
 tags = {
  Name = "${var.cloud_env}_assignment_public_test_subnet_${count.index}"
 }
}

resource "aws_subnet" "assignment_private_test_subnet" {
 count = 2
 vpc_id = aws_vpc.assignment_vpc.id
 cidr_block = var.private_cidrs[count.index]
 map_public_ip_on_launch = false
 availability_zone = data.aws_availability_zones.available.names[count.index]
 
 tags = {
  Name = "${var.cloud_env}_assignment_private_test_subnet_${count.index}"
 }
}

resource "aws_route_table_association" "assignment_public_subnet_association" {
 count = 2
 subnet_id = aws_subnet.assignment_public_test_subnet.*.id[count.index]
 route_table_id = aws_route_table.assignment_public_rt.id
}

resource "aws_route_table_association" "assignment_private_subnet_association" {
 count = 2
 subnet_id = aws_subnet.assignment_private_test_subnet.*.id[count.index]
 route_table_id = aws_default_route_table.assignment_private_rt.id
}

resource "aws_vpc_endpoint" "s3_vpc" {
  vpc_id       = aws_vpc.assignment_vpc.id
  service_name = "com.amazonaws.${var.region}.s3"
}

