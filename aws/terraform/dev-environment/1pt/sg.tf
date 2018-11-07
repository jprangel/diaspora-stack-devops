resource "aws_security_group_rule" "allow_mysql_access" {
  type            = "ingress"
  from_port       = 5432
  to_port         = 5432
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.dev-cluster.id}"
  security_group_id = "${aws_security_group.dev-db.id}"
  description = "Allow connect db port from ecs cluster"
}
resource "aws_security_group" "dev-db" {
  vpc_id = "${aws_vpc.default.id}"
  name   = "dev-db"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags {
      Name = "sg-dev-db"
      Managed = "Terraform"
  }
}


resource "aws_security_group_rule" "allow_alb_access" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  source_security_group_id = "${aws_security_group.dev-alb.id}"
  security_group_id = "${aws_security_group.dev-cluster.id}"
  description = "Allow connect on all ports from load balance"
}
resource "aws_security_group_rule" "allow_ssh_bastion_access" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.dev-bastion.id}"
  security_group_id = "${aws_security_group.dev-cluster.id}"
  description = "Allow connect on SSH ports from Bastion"
}
resource "aws_security_group" "dev-cluster" {
  vpc_id = "${aws_vpc.default.id}"
  name   = "dev-cluster"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags {
      Name = "sg-dev-cluster"
      Managed = "Terraform"
  }
}


resource "aws_security_group_rule" "allow_ssh_internet_access" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dev-bastion.id}"
  description = "Allow connect on SSH port from Internet"
}
resource "aws_security_group" "dev-bastion" {
  vpc_id = "${aws_vpc.default.id}"
  name   = "dev-bastion"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags {
      Name = "sg-dev-bastion"
      Managed = "Terraform"
  }
}


resource "aws_security_group_rule" "allow_http_internet_access" {
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dev-alb.id}"
  description = "Allow connect on HTTP port from Internet"
}
resource "aws_security_group_rule" "allow_https_internet_access" {
  type            = "ingress"
  from_port       = 443
  to_port         = 443
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dev-alb.id}"
  description = "Allow connect on HTTPS port from Internet"
}
resource "aws_security_group" "dev-alb" {

  vpc_id = "${aws_vpc.default.id}"
  name   = "dev-alb"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags {
      Name = "sg-dev-alb"
      Managed = "Terraform"
  }
}



resource "aws_security_group" "dev-cache" {
  name = "dev-redis"
  vpc_id = "${aws_vpc.default.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags {
      Name = "sg-dev-redis"
      Managed = "Terraform"
  }
}
resource "aws_security_group_rule" "allow_cluster_access" {
  type            = "ingress"
  from_port       = 0
  to_port         = 65535
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.dev-cluster.id}"
  security_group_id = "${aws_security_group.dev-cache.id}"
  description = "Allow connect from Cluster"
}
