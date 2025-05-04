# Terraform configuration for creating NACLs and (optionaly) associating them with subnets

resource "aws_network_acl" "nacl" {
  vpc_id = var.vpc_id

  tags = {
    Name = module.naming.nacl
  }
}

# This resource associates the NACL with each subnet in the list
resource "aws_network_acl_association" "assoc" {
  for_each = var.subnet_ids

  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = each.value
}
