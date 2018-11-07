resource "aws_db_instance" "postgresql" {
  allocated_storage          = "10"
  engine                     = "postgres"
  engine_version             = "9.6.10"
  identifier                 = "dev-db"
  instance_class             = "db.t2.micro"
  storage_type               = "gp2"
  iops                       = "0"
  name                       = "${var.db_name}"
  password                   = "${var.db_password}"
  username                   = "${var.db_user}"
  backup_retention_period    = "1"
  backup_window              = "04:00-04:30"
  maintenance_window         = "sun:04:30-sun:05:30"
  auto_minor_version_upgrade = "false"
  skip_final_snapshot        = "true"
  copy_tags_to_snapshot      = "false"
  multi_az                   = "false"
  vpc_security_group_ids     = ["${aws_security_group.dev-db.id}"]
  db_subnet_group_name       = "${aws_db_subnet_group.main.id}"
  parameter_group_name       = "default.postgres9.6"
  storage_encrypted          = "false"
  monitoring_interval        = "30"
  monitoring_role_arn        = "${aws_iam_role.enhanced_monitoring.arn}"
}

data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "enhanced_monitoring" {
  name               = "rds-dev-EnhancedMonitoringRole"
  assume_role_policy = "${data.aws_iam_policy_document.enhanced_monitoring.json}"
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  role       = "${aws_iam_role.enhanced_monitoring.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_subnet_group" "main" {
  name        = "subnet-group-dev-db"
  subnet_ids  = ["${aws_subnet.us-east-1b-private-10-10-30.id}","${aws_subnet.us-east-1c-private-10-10-40.id}"]
  tags {
    Name = "subnet-group-dev-db"
    Managed = "Terraform"
  }
}