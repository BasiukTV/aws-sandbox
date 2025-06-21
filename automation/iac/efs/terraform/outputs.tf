output "efs_name" {
  description = "Name of the EFS file system."
  value       = aws_efs_file_system.efs.name
}

output "efs_id" {
  description = "ID of the EFS file system."
  value       = aws_efs_file_system.efs.id
}

output "efs_mount_targets" {
  description = "Mount targets for the EFS file system."
  value = concat(
    [for mt in aws_efs_mount_target.existing_subnet_mounts : mt.id],
    [for mt in aws_efs_mount_target.new_subnet_mounts : mt.id]
  )
}

output "new_basic_vpc_id" {
  description = "Indicates if a new basic VPC was created for the EFS mount targets."
  value       = var.mount_subnets.new_basic_vpc ? module.vpc[0].vpc_id : null
}

output "new_basic_vpc_subnet_id" {
  description = "Subnet ID of the new basic VPC created for the EFS mount targets."
  value       = var.mount_subnets.new_basic_vpc ? module.vpc[0].subnet_ids["private"] : null
}

output "security_group_id" {
  description = "Security group ID created for the EFS mount targets."
  value       = try(module.sg[0].security_group_id, null)
}
