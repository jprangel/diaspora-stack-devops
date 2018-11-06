variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "172.0.0.0/16"
}

variable "subnet_aws_region_1b" {
    description = "EC2 Region for the VPC"
    default = "us-east-1b"
}

variable "subnet_aws_region_1c" {
    description = "EC2 Region for the VPC"
    default = "us-east-1c"
}

variable "public_subnet_cidr-172-0-0" {
    description = "CIDR for the Public Subnet"
    default = "172.0.0.0/24"
}
variable "public_subnet_cidr-172-0-1" {
    description = "CIDR for the Public Subnet"
    default = "172.0.1.0/24"
}

variable "private_subnet_cidr_172-0-10" {
    description = "CIDR for the Private Subnet"
    default = "172.0.10.0/24"
}

variable "private_subnet_cidr_172-0-20" {
    description = "CIDR for the Private Subnet"
    default = "172.0.20.0/24"
}

variable "private_subnet_cidr_172-0-30" {
    description = "CIDR for the Private Subnet"
    default = "172.0.30.0/24"
}
variable "private_subnet_cidr_172-0-40" {
    description = "CIDR for the Private Subnet"
    default = "172.0.40.0/24"
}

variable "cloudwatch_fullaccess" {
    default = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

variable "s3_fullaccess" {
    default = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

variable "bastion_key" {
    default = "tools-bastion"
}

variable "tools_key" {
    default = "tools-ci"
}

variable "ecs_logging" {
  default     = "[\"json-file\",\"awslogs\"]"
}
variable "cloudwatch_prefix" {
  default     = "/tools"
}
