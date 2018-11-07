variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "aws_elasticache_subnet_1" {
    default = "subnet-"
}

variable "aws_elasticache_subnet_2" {
    default = "subnet-"
}

variable "aws_elasticache_sg" {
    default = "sg-"
}

variable "cluster_name" {
    default = "dev-cluster"
}

variable "cloudwatch_fullaccess" {
    default = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

variable "s3_fullaccess" {
  default = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


