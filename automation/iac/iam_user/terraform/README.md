# Terraform IaC template for IAM Policy

## Notes
Currently only meant to be run locally, while logged into Azure interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. IAM User
2. IAM User Access Key (unless `make_access_key = false` is set)

## Input Variables (with example values)

```
org        = "taras"
app        = "awssbx"
region     = "us-east-2"
env        = "test"

make_access_key = true
```

## Output Examples

```
iam_access_key_id = "AKIAVO4VNDNLLT5HWJXG"
iam_access_key_secret = <sensitive>
iam_user_arn = "arn:aws:iam::375586102102:user/taras-awssbx-iamusr-test-us-east-2"
iam_user_id = "taras-awssbx-iamusr-test-us-east-2"
iam_user_name = "taras-awssbx-iamusr-test-us-east-2"
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
