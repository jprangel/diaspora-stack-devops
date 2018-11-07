resource "aws_iam_role" "role-dev-instance-cluster" {
  name = "role-dev-ecs-cluster"
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
resource "aws_iam_role_policy_attachment" "policy-dev-ecs-instance-cluster-log" {
  role      = "${aws_iam_role.role-dev-instance-cluster.name}"
  policy_arn = "${var.cloudwatch_fullaccess}"
}
resource "aws_iam_role_policy_attachment" "policy-dev-ecs-instance-cluster-task" {
  role      = "${aws_iam_role.role-dev-instance-cluster.name}"
  policy_arn = "${var.ecs_taskexecution}"
}
resource "aws_iam_role_policy_attachment" "policy-dev-ecs-instance-cluster-container" {
  role      = "${aws_iam_role.role-dev-instance-cluster.name}"
  policy_arn = "${var.ecs_ec2container}"
}
resource "aws_iam_role_policy_attachment" "policy-dev-ecs-instance-cluster-alb" {
  role      = "${aws_iam_role.role-dev-instance-cluster.name}"
  policy_arn = "${var.ecs_ec2alb}"
}
resource "aws_iam_instance_profile" "instance-profile-dev-instance-cluster" {
  name = "role-dev-instance-cluster"
  role = "${aws_iam_role.role-dev-instance-cluster.name}"
}





resource "aws_iam_role" "role-dev-instance-bastion" {
  name = "role-dev-instance-bastion"

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
resource "aws_iam_role_policy_attachment" "policy-dev-instance-bastion-log" {
  role      = "${aws_iam_role.role-dev-instance-bastion.name}"
  policy_arn = "${var.cloudwatch_fullaccess}"
}
resource "aws_iam_instance_profile" "instance-profile-dev-instance-bastion" {
  name = "role-dev-instance-bastion"
  role = "${aws_iam_role.role-dev-instance-bastion.name}"
}
