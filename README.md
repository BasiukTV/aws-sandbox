# aws-sandbox
Repo for playing around with some AWS resources.

## General Requirements
1. [AWS Account](https://aws.amazon.com/free)
2. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
3. [AWS User Credentials](https://docs.aws.amazon.com/cli/v1/userguide/cli-authentication-user.html)
4. (one or more) IaC Tools as appropriate
    * [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Folder Structure

```
.
└── automation            # Folders for various automation code/scripts/configuration
    └── iac               # Infrastructure As Code Folder
        ├── vpc           # Folder for a specific AWS resource
        │   ├── terraform # Folder for a specific IaC tool provisioning that resource
        │   └── pulumi    # Another IaC tool
        └── ec2           # Another AWS resource
```

## Explored Resources

| AWS Resource | IaC Links                                       | App Links |
| ------------ | ----------------------------------------------- | --------- |
| Subnet       | [Terraform](./automation/iac/subnet/terraform/) | -         |
| VPC          | [Terraform](./automation/iac/vpc/terraform/)    | -         |
