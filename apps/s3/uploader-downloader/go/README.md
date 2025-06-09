# S3 Uploader-Downloader Go App

This is a simple Go application that allows you to upload and download files to and from an S3 bucket. It uses the AWS SDK for Go to interact with S3.

## Prerequisites
- Go 1.16 or later
- AWS account
- AWS credentials (Access Key ID and Secret Access Key)

## Usage

1. Build the application:
```bash
make all
```

### Run S3 Uploader

* Specification:
```
Usage of ./bin/s3-uploader:
  -access-key-id string
        The AWS access key ID. Can also be set via the AWS_ACCESS_KEY_ID environment variable.
  -bucket string
        The name of the S3 bucket to upload to
  -bucket-folder string
        Optional pseudo-folder (prefix) to upload into inside the S3 bucket
  -dry-run
        Print the actions that would be taken without uploading
  -file string
        The path to the file to upload
  -region string
        The AWS region. Can also be set via the AWS_REGION environment variable.
  -version
```

* Example:
```bash
export AWS_SECRET_ACCESS_KEY=<your-secret-access-key>
./bin/s3-uploader \
    -bucket taras-awssbx-main-s3-test-us-east-1 \
    -bucket-folder test/folder \
    -file data/upload/test_data.txt \
    -region us-east-1 \
    -access-key-id <your-access-key-id>
```

### Run S3 Downloader

* Specification:
```
Usage of ./bin/s3-downloader:
  -access-key-id string
        The AWS access key ID. Can also be set via AWS_ACCESS_KEY_ID
  -bucket string
        The name of the S3 bucket to download from
  -bucket-file string
        The name of the file to download (basename of the object)
  -bucket-folder string
        Optional pseudo-folder (prefix) inside the S3 bucket
  -dry-run
        Print the actions that would be taken without downloading
  -local-path string
        The local downloaded file path (defaults to same name as file)
  -region string
        The AWS region. Can also be set via AWS_REGION
  -version
        Print the version and exit
```

* Example:
```bash
export AWS_SECRET_ACCESS_KEY=<your-secret-access-key>
./bin/s3-downloader \
    -bucket taras-awssbx-main-s3-test-us-east-1 \
    -bucket-folder test/folder \
    -bucket-file test_data.txt \
    -region us-east-1 \
    -access-key-id <your-access-key-id> \
    -local-path data/download/test_data.txt
```

## Folder Structure
```
.
├── bin                   # Folder for compiled binaries
├── data                  # Folder for data files
│   ├── download          # Folder for downloaded files
│   └── upload            # Folder for files to upload
│       └── test_data.txt # Example file to upload
├── downloader            # Folder for the S3 Downloader application
│   └── main.go           # Main file for the S3 Downloader
├── go.mod                # Go module file
├── go.sum                # Go module dependencies
├── Makefile              # Makefile for building the application
├── README.md             # This file
└── uploader              # Folder for the S3 Uploader application
    └── main.go           # Main file for the S3 Uploader
```
