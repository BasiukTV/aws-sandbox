# Terraform IaC template for Elastic Compute Cloud (EC2) provisioning

## Notes
Currently only meant to be run locally, while logged into Azure interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. EC2 instance
2. (by default, configurable) Public Elastic IP (EIP) for the instance
3. (by default, configurable) Security Group with the following rules:
   - SSH (port 22) from anywhere
   - HTTP (port 80) from anywhere
   - HTTPS (port 443) from anywhere

## Input Variable Values (with examples)

```
org        = "taras"
app        = "awssbx"
descriptor = null
env        = "test"
region     = "us-east-1"

ami                 = "ami-09e6f87a47903347c" # Amazon Linux 2023 kernel-6.1 AMI
instance_type       = "t2.micro"
associate_public_ip = true

security_group = {
  existingsecurity_group_id = null
  new_security_group = {
    security_group_description = null
    security_group_vpc_id      = null
    ingress_rules = {
      "allow_ssh" = {
        description = "Allow SSH access from anywhere"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      "allow_http" = {
        description = "Allow HTTP access from anywhere"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
    }
    egress_rules = {
      "allow_all" = {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }
}
```

## Output Values Example
```
ec2_instance_id = "i-0de0e603a357a782b"
ec2_instance_private_ip = "172.31.80.188"
ec2_instance_public_ip = "3.229.238.69"
ec2_name = "taras-awssbx-ec2-test-us-east-1"
eip_id = "eipalloc-021c4f0eeb0ba682e"
eip_name = "taras-awssbx-eip-test-us-east-1"
security_group_ids = toset([
  "sg-04fe126688f664284",
])
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
