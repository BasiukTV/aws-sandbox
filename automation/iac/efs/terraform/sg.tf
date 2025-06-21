// This module is used to create security groups for the EC2 instance
module "sg" {
  source = "../../security_group/terraform"

  count = var.mount_subnets.new_basic_vpc || var.mount_subnets.existing_subnet_ids != null ? 1 : 0

  org        = var.org
  app        = var.app
  descriptor = "efs"
  env        = var.env
  region     = var.region

  security_group_vpc_id = var.mount_subnets.new_basic_vpc ? module.vpc[0].vpc_id : var.mount_subnets.existing_subnet_ids.vpc_id

  security_group_description = "EFS Security Group"
  ingress_rules = {
    "allow_mount" : {
      description = "Allow NFS mount from VPC"
      protocol    = "tcp"
      from_port   = 2049
      to_port     = 2049
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
