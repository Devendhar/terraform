provider "aws" {
  	region  = "us-west-2"
  	profile = "default"
}
		
resource "aws_vpc" "terraformVPC" {
	cidr_block = "10.11.0.0/16"
	enable_dns_support = true
	enable_dns_hostnames = true
	tags {
	 Name = "Terraform VPC"
	}
}

#internet Gateway creation
resource "aws_internet_gateway" "gw" {
	vpc_id = "${aws_vpc.terraformVPC.id}"
	tags {
	 Name = "main"
	}
}

#Creating route to the internet 
resource "aws_route" "terraformRoute" {
	route_table_id = "${aws_vpc.terraformVPC.main_route_table_id}"
	destination_cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_internet_gateway.gw.id}"
}

#Creating public subnet
resource "aws_subnet" "terraformPublicSubnet" {
	vpc_id = "${aws_vpc.terraformVPC.id}"
	cidr_block = "10.11.1.0/24"
	availability_zone = "us-west-2a"
	tags {
	 Name = "Terraform Public Subnet"
	}
}

# Associate subnet terraformPublicSubnet to public route table
resource "aws_route_table_association" "terraformPublicSubnetAssociation" {
	subnet_id = "${aws_subnet.terraformPublicSubnet.id}"
	route_table_id = "${aws_vpc.terraformVPC.main_route_table_id}"
}
