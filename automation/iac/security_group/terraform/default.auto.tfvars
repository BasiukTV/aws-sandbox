# Uncomment the following lines to set your own values for the variables.

# org        = "taras"
# app        = "awssbx"
# descriptor = "ec2"
# env        = "test"
# region     = "us-east-1"

# Values for the security group

# security_group_description = "Security group for the application"
# security_group_vpc_id = "vpc-12345678"
# ingress_rules = {
#   "allow_http" = {
#     description      = "Allow HTTP traffic"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
#   "allow_ssh" = {
#     description      = "Allow SSH traffic"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
# }
# egress_rules = {
#   "allow_all" = {
#     description      = "Allow all outbound traffic"
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
# }
