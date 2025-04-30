# Terraform IaC template for Virtual Private Cloud (VPC) provisioning

## Notes
Currently only meant to be run locally, while logged into Azure interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. Virtual Private Cloud (VPC)
2. (by default) Private subnet
3. (by default) Public subnet

## Input Variable Values (with examples)

```
org    = "taras"
app    = "awssbx"
env    = "test"
region = "us-east-1"

vpc_cidr             = "10.0.0.0/16"
enable_dns_support   = true
enable_dns_hostnames = true

subnets_config = {
    "private" : {
        descriptor = "private"
        cidr       = "10.0.0.0/24"
        zone       = "us-east-1a"
    },
    "public" : {
        descriptor = "public"
        cidr       = "10.0.1.0/24"
        zone       = "us-east-1a"
    }
}
```

## Output Values
```
vpc_id = "vpc-0691fb717fff56d24"
vpc_name = "taras-awssbx-vpc-test-us-east-1"

subnet_ids = {
  "private" = "subnet-0232141ca05260009"
  "public" = "subnet-092291a56d070c860"
}

subnet_names = {
  "private" = "taras-awssbx-private-subnet-test-us-east-1a"
  "public" = "taras-awssbx-public-subnet-test-us-east-1a"
}
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
