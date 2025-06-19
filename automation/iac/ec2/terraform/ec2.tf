resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  # NOTE: Below might not be enough to disable public IP assignment,
  # if the subnet is configured to assign public IPs to any instance.
  associate_public_ip_address = var.associate_public_ip

  # If an existing subnet ID is provided, use it; otherwise, use the public subnet from the VPC module.
  subnet_id = (var.subnet_config.existing_subnet_id != null
    /**/ ? var.subnet_config.existing_subnet_id
  /****/ : module.vpc[0].subnet_ids[var.subnet_config.new_quick_subnet.public_subnet ? "public" : "private"])

  vpc_security_group_ids = [
    var.security_group != null
    /**/ ? var.security_group.existing_security_group_id != null
    /****/ ? var.security_group.existing_security_group_id
    /****/ : one(module.sg).security_group_id
    /**/ : null
  ]

  tags = {
    Name = module.naming.ec2_instance
  }
}
