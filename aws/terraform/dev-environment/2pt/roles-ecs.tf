resource "aws_iam_role" "docker-dev-diaspora" {
  name  = "role-dev-diaspora-container"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "docker-dev-diaspora-policy-attach_logs" {
  role       = "${aws_iam_role.docker-dev-diaspora.name}"
  policy_arn = "${var.cloudwatch_fullaccess}"
}
resource "aws_iam_role_policy_attachment" "docker-dev-diaspora-policy-attach_s3" {
  role       = "${aws_iam_role.docker-dev-diaspora.name}"
  policy_arn = "${var.s3_fullaccess}"
}
