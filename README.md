Created a VPC having 2 Public and 2 Private Subnets with IGW attached and a VPC Gateway endpoint for S3 services.
S3 Bucket creation.
In total 3 environments added - Dev, QA and Prod. Dev & QA enviroments in Mumbai region and Prod in North Virginia region.
Provisioned RDS Instance Database in the private subnet alongwith custom Subnet group, Option group and Parameter group.
Provisioned EC2 Instance in Public subnet
Security Group Inbound Rules for Instance Database has EC2 Private IP dynamically added.
Security Group Inbound Rules for EC2 Instance has MyIP added through main.tf added in environments.
Created IAM Roles, IAM Instance Profile and IAM Policy having read and write data to S3 bucket of the environment.
Backends tf files are separately created for each environment in S3 bucket.