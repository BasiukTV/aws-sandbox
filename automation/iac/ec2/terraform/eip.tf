# Elastic IP for EC2 instance
resource "aws_eip" "eip" {
  instance = aws_instance.ec2.id
  domain   = "vpc"

  count = var.associate_public_ip ? 1 : 0

  tags = {
    Name = module.naming.eip
  }
}