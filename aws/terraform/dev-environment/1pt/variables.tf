variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.10.0.0/16"
}

variable "subnet_aws_region_1b" {
    description = "EC2 Region for the VPC"
    default = "us-east-1b"
}

variable "subnet_aws_region_1c" {
    description = "EC2 Region for the VPC"
    default = "us-east-1c"
}

variable "public_subnet_cidr-10-10-0" {
    description = "CIDR for the Public Subnet"
    default = "10.10.0.0/24"
}
variable "public_subnet_cidr-10-10-1" {
    description = "CIDR for the Public Subnet"
    default = "10.10.1.0/24"
}

variable "private_subnet_cidr_10-10-10" {
    description = "CIDR for the Private Subnet"
    default = "10.10.10.0/24"
}

variable "private_subnet_cidr_10-10-20" {
    description = "CIDR for the Private Subnet"
    default = "10.10.20.0/24"
}

variable "private_subnet_cidr_10-10-30" {
    description = "CIDR for the Private Subnet"
    default = "10.10.30.0/24"
}
variable "private_subnet_cidr_10-10-40" {
    description = "CIDR for the Private Subnet"
    default = "10.10.40.0/24"
}

variable "cloudwatch_fullaccess" {
    default = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
variable "ecs_taskexecution" {
    default = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
variable "ecs_ec2container" {
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
variable "ecs_ec2alb" {
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
variable "s3_fullaccess" {
  default = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
variable "ecs_ec2role" {
  default = "arn:aws:iam::role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
}

variable "bastion_key" {
    default = "dev-bastion"
}
variable "cluster_key" {
    default = "dev-cluster"
}

variable "ecs_config" {
  default     = "echo '' > /etc/ecs/ecs.config"
}
variable "ecs_logging" {
  default     = "[\"json-file\",\"awslogs\"]"
}
variable "cloudwatch_prefix" {
  default     = "/dev-diaspora"
}
variable "ecs_cluster_ami" {
    default = "ami-5253c32d"
}
variable "ecs_cluster_size" {
    default = "t2.small"
}
variable "root_db_password" {
    default = ""
}
variable "root_db_usr" {
    default = "root"
}
variable "docker_name" {
    default = "diaspora"
}
variable "db_name" {
    default = "diaspora_db"
}
variable "db_password" {
    default = ""
}
variable "db_user" {
    default = ""
}
