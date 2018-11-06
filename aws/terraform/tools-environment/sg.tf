resource "aws_security_group_rule" "allow_alb_access" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  source_security_group_id = "${aws_security_group.tools_alb.id}"
  security_group_id = "${aws_security_group.tools-ci.id}"
  description = "Allow connect on all ports from load balance"
}
resource "aws_security_group_rule" "allow_ssh_bastion_access" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.tools-bastion.id}"
  security_group_id = "${aws_security_group.tools-ci.id}"
  description = "Allow connect on SSH ports from Bastion"
}
resource "aws_security_group" "tools-ci" {
  vpc_id = "${aws_vpc.default.id}"
  name   = "tools-ci"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags {
      Name = "sg-tools-ci"
      Managed = "Terraform"
  }
}


resource "aws_security_group_rule" "allow_ssh_internet_access" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.tools-bastion.id}"
  description = "Allow connect on SSH port from Internet"
}
resource "aws_security_group" "tools-bastion" {
  vpc_id = "${aws_vpc.default.id}"
  name   = "tools-bastion"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags {
      Name = "sg-tools-bastion"
      Managed = "Terraform"
  }
}


resource "aws_security_group_rule" "allow_http_internet_access" {
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.tools_alb.id}"
  description = "Allow connect on HTTP port from Internet"
}
resource "aws_security_group_rule" "allow_https_internet_access" {
  type            = "ingress"
  from_port       = 443
  to_port         = 443
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.tools_alb.id}"
  description = "Allow connect on HTTPS port from Internet"
}
resource "aws_security_group" "tools_alb" {

  vpc_id = "${aws_vpc.default.id}"
  name   = "tools-alb"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags {
      Name = "sg-tools-alb"
      Managed = "Terraform"
  }
}

resource "aws_security_group_rule" "allow_alb_access_monitor" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  source_security_group_id = "${aws_security_group.tools_alb.id}"
  security_group_id = "${aws_security_group.tools-monitor.id}"
  description = "Allow connect on all ports from load balance"
}
resource "aws_security_group_rule" "allow_ssh_bastion_access_monitor" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.tools-bastion.id}"
  security_group_id = "${aws_security_group.tools-monitor.id}"
  description = "Allow connect on SSH ports from Bastion"
}
resource "aws_security_group_rule" "allow_rabbitmq_access_monitor" {
  type            = "ingress"
  from_port       = 5671
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.tools-monitor.id}"
  description = "Allow connect on RabbitMQ"
}
resource "aws_security_group" "tools-monitor" {
  vpc_id = "${aws_vpc.default.id}"
  name   = "tools-monitor"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags {
      Name = "sg-tools-monitor"
      Managed = "Terraform"
  }
}

resource "aws_security_group_rule" "allow_alb_access_logs" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  source_security_group_id = "${aws_security_group.tools_alb.id}"
  security_group_id = "${aws_security_group.tools-logs.id}"
  description = "Allow connect on all ports from load balance"
}
resource "aws_security_group_rule" "allow_ssh_bastion_access_logs" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.tools-bastion.id}"
  security_group_id = "${aws_security_group.tools-logs.id}"
  description = "Allow connect on SSH ports from Bastion"
}
resource "aws_security_group_rule" "allow_rabbitmq_access_logs" {
  type            = "ingress"
  from_port       = 9200
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.tools-logs.id}"
  description = "Allow connect on ElasticSearch"
}
resource "aws_security_group" "tools-logs" {
  vpc_id = "${aws_vpc.default.id}"
  name   = "tools-logs"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags {
      Name = "sg-tools-logs"
      Managed = "Terraform"
  }
}