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

resource "aws_instance" "dev-bastion" {
    ami = "${data.aws_ami.amzn_linux.id}"
    instance_type   = "t2.nano"
    monitoring = "true"
    key_name = "${var.bastion_key}"
    associate_public_ip_address = "true"
    subnet_id  = "${aws_subnet.us-east-1b-public.id}"
    vpc_security_group_ids = [ "${aws_security_group.dev-bastion.id}"]
    iam_instance_profile = "${aws_iam_instance_profile.instance-profile-dev-instance-bastion.id}"
    user_data = "${template_file.bastion_user_data.rendered}"
    tags {
        Name = "dev-bastion"
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
  instance = "${aws_instance.dev-bastion.id}"
  vpc = true
  tags {
        Name = "dev-bastion-ip"
        Managed = "Terraform"
    }
}



resource "template_file" "ecs_user_data" {
  filename = "ecs-data.tpl"
  vars {
    ecs_config        = "${var.ecs_config}"
    ecs_logging       = "${var.ecs_logging}"
    cluster_name      = "${var.cluster_name}"
    cloudwatch_prefix = "${var.cloudwatch_prefix}"
    }
}

resource "aws_instance" "dev-cluster" {
    ami = "${var.ecs_cluster_ami}"
    instance_type   = "${var.ecs_cluster_size}"
    monitoring = "true"
    key_name = "${var.cluster_key}"
    subnet_id  = "${aws_subnet.us-east-1b-private-10-10-10.id}"
    vpc_security_group_ids = [ "${aws_security_group.dev-cluster.id}"]
    iam_instance_profile = "${aws_iam_instance_profile.instance-profile-dev-instance-cluster.id}"
    user_data = "${template_file.ecs_user_data.rendered}"
    tags {
        Name = "dev-cluster-1b"
        Managed = "Terraform"
    }
}