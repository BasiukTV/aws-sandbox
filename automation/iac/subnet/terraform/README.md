# Terraform IaC template for subnet provisioning

## Notes
Currently only meant to be run locally, while logged into Azure interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. Subnet

## Input Variables (with example values)

```
org        = "taras"
app        = "awssbx"
descriptor = "private"
env        = "test"
zone       = "us-east-1a"

subnet_name_override = "my-subnet"
subnet_cidr          = "10.0.0.0/16"
vpc_id               = "vpc-12345678"
```

## Output Examples

```
subnet_name = "taras-awssbx-private-subnet-test-us-east-1a"
subnet_id   = "subnet-092291a56d070c860"
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
