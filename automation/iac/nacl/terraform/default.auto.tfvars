# Uncomment the following lines to set your own values for the variables.

# org        = "taras"
# app        = "awssbx"
# env        = "test"
# region     = "us-east-1"
# descriptor = "private"

# Values for NACL association with VPC and subnets

# vpc_id = "vpc-12345678"  # Replace with your actual VPC ID
# subnet_ids = [
#   "subnet-12345678",  # Replace with your actual subnet IDs
#   "subnet-87654321"
# ]

# Values for NACL rules

# allow_public_inbound_ssh = true
# allow_public_inbound_http = true
# allow_public_inbound_https = false
# allow_public_inbound_ping = false
# allow_public_outbound = true

# custom_inbound_rules = {
#   "custom_rule_1" = {
#     rule_number = 150
#     protocol    = "tcp"
#     rule_action = "allow"
#     cidr_block  = "0.0.0/0"  # Allow custom traffic from anywhere
#     from_port   = 8080
#     to_port     = 8080
#   }
# }

# custom_outbound_rules = {
#   "custom_rule_2" = {
#     rule_number = 160
#     protocol    = "tcp"
#     rule_action = "allow"
#     cidr_block  = "0.0.0/0"  # Allow custom traffic to anywhere
#     from_port   = 9090
#     to_port     = 9090
#   }
# }
