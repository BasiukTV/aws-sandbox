# Terraform IaC template for Elastic Compute Cloud (EC2) provisioning

## Notes
Currently only meant to be run locally, while logged into Azure interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. EC2 instance

## Input Variable Values (with examples)

```
org        = "taras"
app        = "awssbx"
descriptor = null
env        = "test"
region     = "us-east-1"
```

## Output Values Example
```
ec2_instance_id = "i-04325c6919c4cf245"
ec2_instance_private_ip = "172.31.82.151"
ec2_instance_public_ip = "44.202.5.211"
ec2_name = "taras-awssbx-ec2-test-us-east-1"
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
