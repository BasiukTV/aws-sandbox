# AWS Terraform Naming Module

## Naming Scheme

The naming scheme used by the module is:
* ```{org}-{app}-{descriptor}-{resource}-{index}-{env}-{region/zone}```

Explanation of inputs/components:
* ```org``` - (optional) the name of the organization owning the resource
* ```app``` - the name of the app owning the resource
* ```descriptor``` - (optional) additional app descriptor (like db, api, web, etc.)
* ```resource``` - resource type shorthand name
* ```index``` - (optional) resource index for multiple resources of the same type
* ```env``` - (optional) name of the deployment environment (like dev, test, prod, etc.)
* ```region``` - (optional) provisioned resource region
* ```zone``` - (optional) provisioned resource zone (includes region, and overrides it)

## Notes
* All components but the ```resource``` are provided by the user. Resource name shorthand is hardcoded into the naming module.

## Usage Example

```
# Module declaration
module "naming" {
    source = "../../commons/naming/terraform"

    org        = var.org
    app        = var.app
    env        = var.env
    region     = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = module.naming.vpc # Module usage
  }
}
```

## Supported Resources

| Resource                  | Resource Name Shorthand | Usage Example                        |
| ------------------------- | ----------------------- | ------------------------------------ |
| EC2                       | ```ec2```               | ```module.naming.ec2_instance```     |
| Elastic File System (EFS) | ```efs```               | ```module.naming.efs```              |
| Elastic IP (EIP)          | ```eip```               | ```module.naming.eip```              |
| IAM Policy                | ```iampol```            | ```module.naming.iam_policy```       |
| IAM User                  | ```iamusr```            | ```module.naming.iam_user```         |
| Internet Gateway          | ```igw```               | ```module.naming.internet_gateway``` |
| Network ACL               | ```nacl```              | ```module.naming.nacl```             |
| Route Table               | ```rt```                | ```module.naming.route_table```      |
| Security Group            | ```sg```                | ```module.naming.security_group```   |
| Subnet                    | ```subnet```            | ```module.naming.subnet```           |
| Virtual Private Cloud     | ```vpc```               | ```module.naming.vpc```              |
