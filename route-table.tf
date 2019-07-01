resource "aws_route_table" "terraform-blue-green-rt" {
  vpc_id = "${var.vpc_id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terraform-blue-green-igw.id}"
  }
  tags = {
    Name = "publicRouteTable"
  }
}