# Main EFS resource definition
resource "aws_efs_file_system" "efs" {
  creation_token = module.naming.efs

  tags = {
    Name = module.naming.efs
  }
}

# Mount targets for the EFS in the specified subnet

# This is used to create mount targets for the EFS in the specified subnets
resource "aws_efs_mount_target" "existing_subnet_mounts" {
  for_each = var.mount_subnets.existing_subnet_ids != null ? var.mount_subnets.existing_subnet_ids : {}

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = each.value.subnet_id
  security_groups = try([module.sg[0].security_group_id], [])
}

# This is used to create mount targets for the EFS in a new basic VPC subnet
resource "aws_efs_mount_target" "new_subnet_mounts" {
  count = var.mount_subnets.new_basic_vpc ? 1 : 0

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = module.vpc[0].subnet_ids["private"]
  security_groups = try([module.sg[0].security_group_id], [])
}
