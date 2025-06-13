# Terraform IaC template for Elastic Compute Cloud (EC2) provisioning

## Notes
Currently only meant to be run locally, while logged into Azure interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. EC2 instance
2. (by default, configurable) Public Elastic IP (EIP) for the instance

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
```

## Output Values Example
```
ec2_instance_id = "i-0da8ac3c70b5a9103"
ec2_instance_private_ip = "172.31.25.234"
ec2_instance_public_ip = "35.172.245.183"
ec2_name = "taras-awssbx-ec2-test-us-east-1"
eip_name = "taras-awssbx-eip-test-us-east-1"
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
