resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  # NOTE: Below might not be enough to disable public IP assignment,
  # if the subnet is configured to assign public IPs to any instance.
  associate_public_ip_address = var.associate_public_ip

  tags = {
    Name = module.naming.ec2_instance
  }
}