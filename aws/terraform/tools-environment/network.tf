provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
    tags {
          Name = "tools-int-gw"
          Managed = "Terraform"
      }
}

resource "aws_eip" "nat_gw_eip_1b" {
  vpc = true
  depends_on = ["aws_internet_gateway.default"]
  tags {
        Name = "tools-nat-gw-ip-1b"
        Managed = "Terraform"
    }
}

resource "aws_eip" "nat_gw_eip_1c" {
  vpc = true
  depends_on = ["aws_internet_gateway.default"]
  tags {
        Name = "tools-nat-gw-ip-1c"
        Managed = "Terraform"
    }
}

resource "aws_nat_gateway" "default" {
    allocation_id = "${aws_eip.nat_gw_eip_1b.id}"
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    depends_on = ["aws_internet_gateway.default"]
    tags {
          Name = "tools-nat-gw-1b"
          Managed = "Terraform"
      }
}

resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags {
        Name = "tools-vpc"
        Managed = "Terraform"
    }
}

resource "aws_subnet" "us-east-1b-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet_cidr-172-0-0}"
    availability_zone = "${var.subnet_aws_region_1b}"
    map_public_ip_on_launch = true
    tags {
        Name = "tools-public-subnet-1b-172-0-0"
        Managed = "Terraform"
    }
}

resource "aws_subnet" "us-east-1c-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet_cidr-172-0-1}"
    availability_zone = "${var.subnet_aws_region_1c}"
    map_public_ip_on_launch = true
    tags {
        Name = "tools-public-subnet-1c-172-0-1"
        Managed = "Terraform"
    }
}

resource "aws_route_table" "us-east-tools-public" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }
    tags {
        Name = "tools-public-route-table"
        Managed = "Terraform"
    }
}

resource "aws_route_table_association" "us-east-1b-tools-public" {
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    route_table_id = "${aws_route_table.us-east-tools-public.id}"
}

resource "aws_route_table_association" "us-east-1c-tools-public" {
    subnet_id = "${aws_subnet.us-east-1c-public.id}"
    route_table_id = "${aws_route_table.us-east-tools-public.id}"
}

resource "aws_subnet" "us-east-1b-private-172-0-10" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.private_subnet_cidr_172-0-10}"
    availability_zone = "${var.subnet_aws_region_1b}"
    tags {
      Name = "tools-private-subnet-app-1b-172-0-10"
      Managed = "Terraform"
    }
}
resource "aws_subnet" "us-east-1c-private-172-0-20" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.private_subnet_cidr_172-0-20}"
    availability_zone = "${var.subnet_aws_region_1c}"
    tags {
      Name = "tools-private-subnet-app-1c-172-0-20"
      Managed = "Terraform"
    }
}

resource "aws_subnet" "us-east-1c-private-172-0-40" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.private_subnet_cidr_172-0-40}"
    availability_zone = "${var.subnet_aws_region_1c}"
    tags {
      Name = "tools-private-subnet-db-1c-172-0-40"
      Managed = "Terraform"
    }
}
resource "aws_subnet" "us-east-1b-private-172-0-30" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.private_subnet_cidr_172-0-30}"
    availability_zone = "${var.subnet_aws_region_1b}"
    tags {
      Name = "tools-private-subnet-db-1b-172-0-30"
      Managed = "Terraform"
    }
}

resource "aws_route_table" "us-east-tools-private" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.default.id}"
    }

    tags {
      Name = "tools-private-route-table"
      Managed = "Terraform"
    }
}

resource "aws_route_table_association" "us-east-1b-tools-private-172-0-10" {
    subnet_id = "${aws_subnet.us-east-1b-private-172-0-10.id}"
    route_table_id = "${aws_route_table.us-east-tools-private.id}"
}
resource "aws_route_table_association" "us-east-1c-tools-private-172-0-20" {
    subnet_id = "${aws_subnet.us-east-1c-private-172-0-20.id}"
    route_table_id = "${aws_route_table.us-east-tools-private.id}"
}

resource "aws_route_table_association" "us-east-1c-tools-private-172-0-40" {
    subnet_id = "${aws_subnet.us-east-1c-private-172-0-40.id}"
    route_table_id = "${aws_route_table.us-east-tools-private.id}"
}
resource "aws_route_table_association" "us-east-1b-tools-private-172-0-30" {
    subnet_id = "${aws_subnet.us-east-1b-private-172-0-30.id}"
    route_table_id = "${aws_route_table.us-east-tools-private.id}"
}
