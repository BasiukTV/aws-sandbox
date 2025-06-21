# Terraform IaC template for Elastic File System (EFS) on AWS

## Notes
Currently only meant to be run locally, while logged into AWS interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. EFS
2. (Optionally) EFS Mount Targets in the specified VPC and Subnets
3. (Optionally) New VPC, Subnets, Security Groups, and an EFS Mount Target

## Input Variable Values (with examples)

```
# org       = "taras"
# app       = "awssbx"
# env       = "test"
# region    = "us-east-1"
# descriptor = "private"

# mount_subnets = {
#   existing_subnet_ids = {}
#   new_basic_vpc       = false
# }
```

## Output Values
```
efs_id = "fs-0815d1c7d96e4e108"
efs_mount_targets = [
  "fsmt-065b958799da9806b",
]
efs_name = "taras-awssbx-efs-test-us-east-1"
new_basic_vpc_id = "vpc-02eb44d718b861d6e"
new_basic_vpc_subnet_id = "subnet-05221e564e95adcb6"
security_group_id = "sg-0e71e07ff4fd15d5f"
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
