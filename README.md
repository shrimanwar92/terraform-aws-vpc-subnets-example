# terraform-aws-vpc-subnets-example
This example demonstrates how can we deploy EC2 instance with a custom vpc and subnets.

This example uses keypairs created using ssh-keygen.
VPC is created using aws cli tool. (Refer vpc.tf)
For example, aws ec2 create-vpc --cidr-block 10.0.0.0/16
