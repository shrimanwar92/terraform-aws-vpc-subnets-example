locals {
	subnets = "${aws_subnet.terraform-blue-green.*.id}"

	user_data = <<-EOF
  		#!/bin/bash
  		echo "Hello, World" > index.html
  		nohup busybox httpd -f -p 8080 &
  	EOF
}

resource "aws_instance" "terraform-blue-green" {
	count                  = 3
	ami                    = "ami-baa236c2"
	instance_type          = "t2.micro"
	subnet_id              = "${local.subnets[count.index]}"
	vpc_security_group_ids = ["${aws_security_group.terraform-blue-green.id}"]
	key_name               = "${aws_key_pair.terraform-blue-green.key_name}"
	depends_on             = ["aws_internet_gateway.terraform-blue-green-igw"]

	user_data = "${local.user_data}"

	tags = {
		Name = "Terraform Blue/Green - ${count.index + 1} (v${var.infrastructure_version})"
		InfrastructureVersion = "${var.infrastructure_version}"
	}
}

output "instance_public_ips" {
	value = "${aws_instance.terraform-blue-green.*.public_ip}"
}