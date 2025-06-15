# aws-sandbox
Repo for playing around with some AWS resources.

## General Requirements
1. [AWS Account](https://aws.amazon.com/free)
2. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
3. [AWS User Credentials](https://docs.aws.amazon.com/cli/v1/userguide/cli-authentication-user.html)
4. (one or more) IaC Tools as appropriate
    * [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
5. (one or more) Programming Language build tools as appropriate
    * [Go](https://go.dev/doc/install)
    * [Python](https://www.python.org/downloads/)

## Folder Structure

```
.
├── apps                        # Applications that use AWS resources
│   └── s3                      # Apps that use S3
│       └── uploader-downloader # Specific App that uses the S3
│           └── go              # Go implementation of S3 App
├── automation                  # Automation scripts and IaC
│   └── iac                     # Infrastructure as Code
│       ├── ec2                 # EC2 related resources
│       │   └── terraform       # Terraform scripts for EC2
│       ├── ...                 # Other AWS resources
│       ├── s3                  # S3 related resources
│       │   └── cfn             # CloudFormation scripts for S3
│       └── vpc                 # VPC related resources
│           └── terraform       # Terraform scripts for VPC
└── README.md                   # This file
```

## Explored Resources

| AWS Resource                | IaC Links                                               | App Links                                                   |
| --------------------------- | ------------------------------------------------------- | ----------------------------------------------------------- |
| EC2                         | [Terraform](./automation/iac/ec2/terraform/)            | -                                                           |
| IAM Policy                  | [Terraform](./automation/iac/iam_policy/terraform/)     | -                                                           |
| IAM User                    | [Terraform](./automation/iac/iam_user/terraform/)       | -                                                           |
| Internet Gateway            | [Terraform](./automation/iac/igw/terraform/)            | -                                                           |
| Network ACL (NACL)          | [Terraform](./automation/iac/nacl/terraform/)           | -                                                           |
| Simple Storage Service (S3) | [CloudFormation](./automation/iac/s3/cfn/)              | [Go Uploader-Downloader](./apps/s3/uploader-downloader/go/) |
| Security Group              | [Terraform](./automation/iac/security_group/terraform/) | -                                                           |
| Subnet                      | [Terraform](./automation/iac/subnet/terraform/)         | -                                                           |
| VPC                         | [Terraform](./automation/iac/vpc/terraform/)            | -                                                           |
