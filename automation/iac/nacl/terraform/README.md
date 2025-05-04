# Terraform IaC template for Virtual Private Cloud (VPC) provisioning

## Notes
Currently only meant to be run locally, while logged into Azure interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. Network Access Control List (NACL) resource
2. Associate the NACL with a give VPC
3. Associate the NACL with a given set of VPC subnets
4. NACL rules to allow public inbound and outbound SSH, HTTP, HTTPS and ping connection to the subnets
5. NACL rule to allow public outbound conections from subnets

## Input Variable Values (with examples)

```
# org       = "taras"
# app       = "awssbx"
# env       = "test"
# region    = "us-east-1"
# desriptor = "private"

# Values for NACL association with VPC and subnets

# vpc_id = "vpc-12345678"  # Replace with your actual VPC ID
# subnet_ids = [
#   "subnet-12345678",  # Replace with your actual subnet IDs
#   "subnet-87654321"
# ]

# Values for NACL rules

allow_public_inbound_ssh = true
allow_public_inbound_http = true
allow_public_inbound_https = true
allow_public_inbound_ping = true
allow_public_outbound = true

custom_inbound_rules = {
  "custom_rule_1" = {
    rule_number = 150
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0/0"  # Allow custom traffic from anywhere
    from_port   = 8080
    to_port     = 8080
  }
}

custom_outbound_rules = {
  "custom_rule_2" = {
    rule_number = 160
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0/0"  # Allow custom traffic to anywhere
    from_port   = 9090
    to_port     = 9090
  }
}
```

## Output Values
```
nacl_id = "nacl-12345678"
nacl_name = "nacl-name"
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
