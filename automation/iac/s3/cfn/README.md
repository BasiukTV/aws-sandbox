# Cloud Formation Template for AWS S3 Bucket Provisioning

## Provisioned Infra

By default this Terraform configuration will provision:
1. S3 Bucket
2. IAM User
3. IAM Policy for the User to access the S3 Bucket
4. IAM Access Key for the User

## Input Variable Values (with examples)

```
Org         = "taras"
App         = "awssbx"
Descriptor  = "name"
Environment = "test"
Region      = "us-east-1"
```

## Output Values
```
[
    {
        "OutputKey": "S3BucketUserAccessKeyId",
        "OutputValue": "<redacted>",
        "Description": "The access key ID for the IAM user"
    },
    {
        "OutputKey": "S3BucketUserSecretAccessKey",
        "OutputValue": "<redacted>",
        "Description": "The secret access key for the IAM user"
    },
    {
        "OutputKey": "S3BucketDomainName",
        "OutputValue": "taras-awssbx-main-s3-test-us-east-1.s3.amazonaws.com",
        "Description": "The domain name of the created S3 bucket"
    },
    {
        "OutputKey": "S3BucketArn",
        "OutputValue": "arn:aws:s3:::taras-awssbx-main-s3-test-us-east-1",
        "Description": "The ARN of the created S3 bucket"
    },
    {
        "OutputKey": "S3BucketName",
        "OutputValue": "taras-awssbx-main-s3-test-us-east-1",
        "Description": "The name of the created S3 bucket"
    },
    {
        "OutputKey": "S3BucketUserName",
        "OutputValue": "taras-awssbx-main-s3-user-test",
        "Description": "The name of the IAM user with access to the S3 bucket"
    }
]
```

## Usage

### Provision

1. Login to your AWS account with the AWS CLI:
```bash
aws configure
```
2. Run the following command to create the stack (replace the values with your own):
```bash
export ORG=taras
export APP=awssbx
export DESCRIPTOR=main
export ENVIRONMENT=test
export REGION=us-east-1
aws cloudformation create-stack \
    --stack-name "$ORG-$APP-$DESCRIPTOR-s3-$ENVIRONMENT-$REGION-stack" \
    --template-body file://s3.cfn.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameters \
    ParameterKey=Org,ParameterValue=$ORG \
    ParameterKey=App,ParameterValue=$APP \
    ParameterKey=Descriptor,ParameterValue=$DESCRIPTOR \
    ParameterKey=Environment,ParameterValue=$ENVIRONMENT \
    ParameterKey=Region,ParameterValue=$REGION
```

3. Wait for the stack creation to complete. You can check the status with:
```bash
aws cloudformation describe-stacks --stack-name "$ORG-$APP-$DESCRIPTOR-s3-$ENVIRONMENT-$REGION-stack"
```
... or just wait for the below command to complete:
```bash
aws cloudformation wait stack-create-complete --stack-name "$ORG-$APP-$DESCRIPTOR-s3-$ENVIRONMENT-$REGION-stack"
```

4. Once the stack is created, you can retrieve the outputs (like S3 Bucket name, IAM User credentials) with:
```bash
aws cloudformation describe-stacks --stack-name "$ORG-$APP-$DESCRIPTOR-s3-$ENVIRONMENT-$REGION-stack" --query "Stacks[0].Outputs"
```

### Clean Up
1. To remove the resources in the cloud, run from this directory:
```bash
aws cloudformation delete-stack --stack-name "$ORG-$APP-$DESCRIPTOR-s3-$ENVIRONMENT-$REGION-stack"
```
