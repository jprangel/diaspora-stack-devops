data "aws_ami" "amzn_linux" {
  most_recent = true
  filter {
    name = "name"
    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}

resource "aws_instance" "tools-bastion" {
    ami = "${data.aws_ami.amzn_linux.id}"
    instance_type   = "t2.nano"
    monitoring = "true"
    key_name = "${var.bastion_key}"
    associate_public_ip_address = "true"
    subnet_id  = "${aws_subnet.us-east-1b-public.id}"
    vpc_security_group_ids = [ "${aws_security_group.tools-bastion.id}"]
    iam_instance_profile = "${aws_iam_instance_profile.instance-profile-tools-instance-bastion.id}"
    user_data = "${template_file.bastion_user_data.rendered}"
    tags {
        Name = "tools-bastion"
        Managed = "Terraform"
    }
}
resource "template_file" "bastion_user_data" {
  filename = "bastion-data.tpl"
  vars {
    cloudwatch_prefix = "${var.cloudwatch_prefix}"
    }
}
resource "aws_eip" "bastion_eip" {
  instance = "${aws_instance.tools-bastion.id}"
  vpc = true
  tags {
        Name = "tools-bastion-ip"
        Managed = "Terraform"
    }
}



resource "aws_instance" "tools-ci" {
    ami = "${data.aws_ami.amzn_linux.id}"
    instance_type   = "t2.small"
    monitoring = "true"
    key_name = "${var.tools_key}"
    associate_public_ip_address = "true"
    subnet_id  = "${aws_subnet.us-east-1b-private-172-0-10.id}"
    vpc_security_group_ids = [ "${aws_security_group.tools-ci.id}"]
    iam_instance_profile = "${aws_iam_instance_profile.instance-profile-tools-instance-ci.id}"
    user_data = "${template_file.ci_user_data.rendered}"
    tags {
        Name = "tools-ci"
        Managed = "Terraform"
    }
}
resource "template_file" "ci_user_data" {
  filename = "ci-data.tpl"
  vars {
    cloudwatch_prefix = "${var.cloudwatch_prefix}"
    }
}



resource "aws_instance" "tools-monitor" {
    ami = "${data.aws_ami.amzn_linux.id}"
    instance_type   = "t2.small"
    monitoring = "true"
    key_name = "${var.tools_key}"
    associate_public_ip_address = "true"
    subnet_id  = "${aws_subnet.us-east-1b-private-172-0-10.id}"
    vpc_security_group_ids = [ "${aws_security_group.tools-monitor.id}"]
    iam_instance_profile = "${aws_iam_instance_profile.instance-profile-tools-instance-monitor.id}"
    user_data = "${template_file.monitor_user_data.rendered}"
    tags {
        Name = "tools-monitor"
        Managed = "Terraform"
    }
}
resource "template_file" "monitor_user_data" {
  filename = "monitor-data.tpl"
  vars {
    cloudwatch_prefix = "${var.cloudwatch_prefix}"
    }
}



resource "aws_instance" "tools-logs" {
    ami = "${data.aws_ami.amzn_linux.id}"
    instance_type   = "t2.meidum"
    monitoring = "true"
    key_name = "${var.tools_key}"
    associate_public_ip_address = "true"
    subnet_id  = "${aws_subnet.us-east-1b-private-172-0-10.id}"
    vpc_security_group_ids = [ "${aws_security_group.tools-logs.id}"]
    iam_instance_profile = "${aws_iam_instance_profile.instance-profile-tools-instance-logs.id}"
    user_data = "${template_file.logs_user_data.rendered}"
    tags {
        Name = "tools-logs"
        Managed = "Terraform"
    }
}
resource "template_file" "logs_user_data" {
  filename = "logs-data.tpl"
  vars {
    cloudwatch_prefix = "${var.cloudwatch_prefix}"
    }
}