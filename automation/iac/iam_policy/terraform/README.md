# Terraform IaC template for IAM Policy

## Notes
Currently only meant to be run locally, while logged into Azure interactively (via a browser pop-up).

## Provisioned Infra

By default this Terraform configuration will provision:
1. IAM Policy with specified permissions

## Input Variables (with example values)

```
org        = "taras"
app        = "awssbx"
env        = "test"
region     = "us-east-1"

policy_description = "S3 bucket read access policy."
policy_statement = {
  actions   = ["s3:ListBucket", "s3:GetObject"]
  resources = ["arn:aws:s3:::", "arn:aws:s3:::/*"]
}
```

## Output Examples

```
iam_policy_arn = "arn:aws:iam::<user_id>:policy/taras-awssbx-iampol-test-us-east-2"
iam_policy_description = "IAM policy for S3 bucket read access."
iam_policy_document = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::/*",
        "arn:aws:s3:::"
      ]
    }
  ]
}
EOT
iam_policy_id = "arn:aws:iam::<user_id>:policy/taras-awssbx-iampol-test-us-east-2"
iam_policy_name = "taras-awssbx-iampol-test-us-east-2"
iam_policy_path = "/"
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
