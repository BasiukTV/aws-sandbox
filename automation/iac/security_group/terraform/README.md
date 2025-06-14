# Terraform IaC template for Security Group provisioning

## Notes
Currently only meant to be run locally, while logged into Azure interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. Security Group (SG) resource
2. Associate the SG with a given VPC (if provided)
3. Ingress rules (by default allow any SSH and HTTP)
4. Egress rules (by default allow all outbound traffic)

## Input Variable Values (with examples)

```
# org        = "taras"
# app        = "awssbx"
# descriptor = "ec2"
# env        = "test"
# region     = "us-east-1"

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
```

## Output Values
```
security_group_id = "sg-042072028c199726d"
security_group_name = "taras-awssbx-ec2-sg-test-us-east-1"
```

## Usage

### Provision

To provision the resources, run from this directory (setting up .terraform folder in your $HOME is optional):
```
aws configure
mkdir -p $HOME/.terraform
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform"
terraform init
terraform apply
```

#### Options
See the [Default Variables Values File](./default.auto.tfvars). Uncomment the line you wish to modify, change the value and re-provision the infrastructure by running the steps above.

### Clean Up
1. To remove the resources in the cloud, run from this directory:
```
terraform destroy
```
2. (optionally) Delete the Terraform downloaded libraries located in .terraform* directories
3. (optionally) Delete the state files located in \*.tfstate\* files
