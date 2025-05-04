# NACL rules for inbound and outbound traffic

# network_acl_id - (Required) The ID of the network ACL.
# rule_number - (Required) The rule number for the entry (for example, 100). ACL entries are processed in ascending order by rule number.
# egress - (Optional, bool) Indicates whether this is an egress rule (rule is applied to traffic leaving the subnet). Default false.
# protocol - (Required) The protocol. A value of -1 means all protocols.
# rule_action - (Required) Indicates whether to allow or deny the traffic that matches the rule. Accepted values: allow | deny
# cidr_block - (Optional) The network range to allow or deny, in CIDR notation (for example 172.16.0.0/24 ).
# ipv6_cidr_block - (Optional) The IPv6 CIDR block to allow or deny.
# from_port - (Optional) The from port to match.
# to_port - (Optional) The to port to match.

# Handling allowing public SSH traffic

resource "aws_network_acl_rule" "public_inbound_ssh" {
  count = var.allow_public_inbound_ssh ? 1 : 0

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow SSH from anywhere
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "public_outbound_ssh" {
  count = var.allow_public_inbound_ssh ? 1 : 0

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow SSH to anywhere
  from_port      = 1024
  to_port        = 65535
}

# Handling allowing public HTTP traffic

resource "aws_network_acl_rule" "public_inbound_http" {
  count = var.allow_public_inbound_http ? 1 : 0

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow HTTP from anywhere
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_outbound_http" {
  count = var.allow_public_inbound_http ? 1 : 0

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 110
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow HTTP to anywhere
  from_port      = 1024
  to_port        = 65535
}

# Handling allowing public HTTPS traffic

resource "aws_network_acl_rule" "public_inbound_https" {
  count = var.allow_public_inbound_https ? 1 : 0

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 120
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow HTTPS from anywhere
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_outbound_https" {
  count = var.allow_public_inbound_https ? 1 : 0

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 120
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow HTTPS to anywhere
  from_port      = 1024
  to_port        = 65535
}

# Handling allowing public ICMP traffic (ping)

resource "aws_network_acl_rule" "public_inbound_ping" {
  count = var.allow_public_inbound_ping ? 1 : 0

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 130
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow ICMP from anywhere
}

resource "aws_network_acl_rule" "public_outbound_ping" {
  count = var.allow_public_inbound_ping ? 1 : 0

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 130
  egress         = true
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow ICMP to anywhere
}

# Handling allowing public outbound traffic

resource "aws_network_acl_rule" "public_outbound" {
  count = var.allow_public_outbound ? 1 : 0

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 200
  egress         = true
  protocol       = "-1" # All protocols
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow all outbound traffic
}

# Handling custom inbound rules

resource "aws_network_acl_rule" "custom_inbound" {
  for_each = var.custom_inbound_rules

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

# Handling custom outbound rules

resource "aws_network_acl_rule" "custom_outbound" {
  for_each = var.custom_outbound_rules

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}
