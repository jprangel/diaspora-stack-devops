resource "aws_iam_role" "role-tools-ci-instance" {
  name = "role-tools-ci"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "policy-tools-ci-instance-log" {
  role      = "${aws_iam_role.role-tools-ci-instance.name}"
  policy_arn = "${var.cloudwatch_fullaccess}"
}
resource "aws_iam_role_policy_attachment" "policy-tools-ci-instance-s3" {
  role      = "${aws_iam_role.role-tools-ci-instance.name}"
  policy_arn = "${var.s3_fullaccess}"
}
resource "aws_iam_instance_profile" "instance-profile-tools-instance-ci" {
  name = "role-tools-instance-ci"
  role = "${aws_iam_role.role-tools-ci-instance.name}"
}


resource "aws_iam_role" "role-tools-instance-bastion" {
  name = "role-tools-instance-bastion"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "policy-tools-instance-bastion-log" {
  role      = "${aws_iam_role.role-tools-instance-bastion.name}"
  policy_arn = "${var.cloudwatch_fullaccess}"
}
resource "aws_iam_instance_profile" "instance-profile-tools-instance-bastion" {
  name = "role-tools-instance-bastion"
  role = "${aws_iam_role.role-tools-instance-bastion.name}"
}


resource "aws_iam_role" "role-tools-monitor-instance" {
  name = "role-tools-monitor"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "policy-tools-monitor-instance-log" {
  role      = "${aws_iam_role.role-tools-monitor-instance.name}"
  policy_arn = "${var.cloudwatch_fullaccess}"
}
resource "aws_iam_role_policy_attachment" "policy-tools-monitor-instance-s3" {
  role      = "${aws_iam_role.role-tools-monitor-instance.name}"
  policy_arn = "${var.s3_fullaccess}"
}
resource "aws_iam_instance_profile" "instance-profile-tools-instance-monitor" {
  name = "role-tools-instance-monitor"
  role = "${aws_iam_role.role-tools-monitor-instance.name}"
}

resource "aws_iam_role" "role-tools-logs-instance" {
  name = "role-logs-monitor"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "policy-tools-logs-instance-log" {
  role      = "${aws_iam_role.role-tools-logs-instance.name}"
  policy_arn = "${var.cloudwatch_fullaccess}"
}
resource "aws_iam_role_policy_attachment" "policy-tools-logs-instance-s3" {
  role      = "${aws_iam_role.role-tools-logs-instance.name}"
  policy_arn = "${var.s3_fullaccess}"
}
resource "aws_iam_instance_profile" "instance-profile-tools-instance-logs" {
  name = "role-tools-instance-logs"
  role = "${aws_iam_role.role-tools-logs-instance.name}"
}