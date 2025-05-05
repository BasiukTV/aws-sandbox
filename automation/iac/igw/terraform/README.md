# Terraform IaC template for Internet Gateway provisioning

## Notes
Currently only meant to be run locally, while logged into Azure interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. Internet Gateway associated with given VPC
2. Route Table routing traffic to the above IGW associated with given list of subnets

## Input Variables (with example values)

```
org        = "taras"
app        = "awssbx"
descriptor = "public"
env        = "test"
region     = "us-east-1"

vpc_id = "vpc-12345678"
subnet_ids = ["subnet-12345", "subnet-67890"]
```

## Output Examples

```
igw_name = "taras-awssbx-private-igw-test-us-east-1"
igw_id   = "igw-092291a56d070c860"
route_table_name = "taras-awssbx-private-rt-test-us-east-1"
route_table_id   = "rt-092291a56d070c860"
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
