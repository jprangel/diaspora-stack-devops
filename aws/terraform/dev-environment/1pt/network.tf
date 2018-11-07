provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
    tags {
          Name = "dev-diaspora-int-gw"
          Managed = "Terraform"
      }
}

resource "aws_eip" "nat_gw_eip_1b" {
  vpc = true
  depends_on = ["aws_internet_gateway.default"]
  tags {
        Name = "dev-diaspora-nat-gw-ip-1b"
        Managed = "Terraform"
    }
}


resource "aws_nat_gateway" "default" {
    allocation_id = "${aws_eip.nat_gw_eip_1b.id}"
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    depends_on = ["aws_internet_gateway.default"]
    tags {
          Name = "dev-diaspora-nat-gw-1b"
          Managed = "Terraform"
      }
}

resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags {
        Name = "dev-diaspora-vpc"
        Managed = "Terraform"
    }
}

resource "aws_subnet" "us-east-1b-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet_cidr-10-10-0}"
    availability_zone = "${var.subnet_aws_region_1b}"
    map_public_ip_on_launch = true
    tags {
        Name = "dev-diaspora-public-subnet-1b-10-10-0"
        Managed = "Terraform"
    }
}

resource "aws_subnet" "us-east-1c-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet_cidr-10-10-1}"
    availability_zone = "${var.subnet_aws_region_1c}"
    map_public_ip_on_launch = true
    tags {
        Name = "dev-diaspora-public-subnet-1c-10-10-1"
        Managed = "Terraform"
    }
}

resource "aws_route_table" "us-east-dev-diaspora-public" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }
    tags {
        Name = "dev-diaspora-public-route-table"
        Managed = "Terraform"
    }
}

resource "aws_route_table_association" "us-east-1b-dev-diaspora-public" {
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    route_table_id = "${aws_route_table.us-east-dev-diaspora-public.id}"
}

resource "aws_route_table_association" "us-east-1c-dev-diaspora-public" {
    subnet_id = "${aws_subnet.us-east-1c-public.id}"
    route_table_id = "${aws_route_table.us-east-dev-diaspora-public.id}"
}

resource "aws_subnet" "us-east-1b-private-10-10-10" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.private_subnet_cidr_10-10-10}"
    availability_zone = "${var.subnet_aws_region_1b}"
    tags {
      Name = "dev-diaspora-private-subnet-app-1b-10-10-10"
      Managed = "Terraform"
    }
}
resource "aws_subnet" "us-east-1c-private-10-10-20" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.private_subnet_cidr_10-10-20}"
    availability_zone = "${var.subnet_aws_region_1c}"
    tags {
      Name = "dev-diaspora-private-subnet-app-1c-10-10-20"
      Managed = "Terraform"
    }
}

resource "aws_subnet" "us-east-1c-private-10-10-40" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.private_subnet_cidr_10-10-40}"
    availability_zone = "${var.subnet_aws_region_1c}"
    tags {
      Name = "dev-diaspora-private-subnet-db-1c-10-10-40"
      Managed = "Terraform"
    }
}
resource "aws_subnet" "us-east-1b-private-10-10-30" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.private_subnet_cidr_10-10-30}"
    availability_zone = "${var.subnet_aws_region_1b}"
    tags {
      Name = "dev-diaspora-private-subnet-db-1b-10-10-30"
      Managed = "Terraform"
    }
}

resource "aws_route_table" "us-east-dev-diaspora-private" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.default.id}"
    }

    tags {
      Name = "dev-diaspora-private-route-table"
      Managed = "Terraform"
    }
}

resource "aws_route_table_association" "us-east-1b-dev-diaspora-private-10-10-10" {
    subnet_id = "${aws_subnet.us-east-1b-private-10-10-10.id}"
    route_table_id = "${aws_route_table.us-east-dev-diaspora-private.id}"
}
resource "aws_route_table_association" "us-east-1c-dev-diaspora-private-10-10-20" {
    subnet_id = "${aws_subnet.us-east-1c-private-10-10-20.id}"
    route_table_id = "${aws_route_table.us-east-dev-diaspora-private.id}"
}

resource "aws_route_table_association" "us-east-1c-dev-diaspora-private-10-10-40" {
    subnet_id = "${aws_subnet.us-east-1c-private-10-10-40.id}"
    route_table_id = "${aws_route_table.us-east-dev-diaspora-private.id}"
}
resource "aws_route_table_association" "us-east-1b-dev-diaspora-private-10-10-30" {
    subnet_id = "${aws_subnet.us-east-1b-private-10-10-30.id}"
    route_table_id = "${aws_route_table.us-east-dev-diaspora-private.id}"
}
