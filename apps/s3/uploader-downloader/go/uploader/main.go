package main

import (
	"context"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/feature/s3/manager"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

var version = "v1.0.0"

func uploadFileToS3(bucketName, filePath, bucketFolder, region, accessKeyID, secretAccessKey string) error {
	// Open the input file
	file, err := os.Open(filePath)
	if err != nil {
		return fmt.Errorf("failed to open file %q: %w", filePath, err)
	}
	defer file.Close()

	// Load AWS config with static credentials
	sessionToken := os.Getenv("AWS_SESSION_TOKEN")
	cfg, err := config.LoadDefaultConfig(context.Background(),
		config.WithRegion(region),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider(accessKeyID, secretAccessKey, sessionToken)),
	)
	if err != nil {
		return fmt.Errorf("failed to load AWS config: %w", err)
	}

	// Create S3 client and uploader
	client := s3.NewFromConfig(cfg)
	uploader := manager.NewUploader(client)

	key := filepath.Base(filePath)

	// Append bucket folder prefix if given
	if bucketFolder != "" {
		bucketFolder = strings.Trim(bucketFolder, "/") + "/"
		key = bucketFolder + key
	}

	// Upload
	fmt.Printf("Uploading file %s to bucket %s as key %s\n", filePath, bucketName, key)
	_, err = uploader.Upload(context.Background(), &s3.PutObjectInput{
		Bucket: &bucketName,
		Key:    &key,
		Body:   file,
	})
	if err != nil {
		return fmt.Errorf("failed to upload file to S3: %w", err)
	}

	fmt.Printf("Successfully uploaded %s to S3\n", filePath)
	fmt.Printf("s3://%s/%s\n", bucketName, key)
	return nil
}

func main() {
	// Define command-line flags
	bucketName := flag.String("bucket", "", "The name of the S3 bucket to upload to")
	filePath := flag.String("file", "", "The path to the file to upload")
	bucketFolder := flag.String("bucket-folder", "", "Optional pseudo-folder (prefix) to upload into inside the S3 bucket")
	region := flag.String("region", "", "The AWS region. Can also be set via the AWS_REGION environment variable.")
	accessKeyID := flag.String("access-key-id", "", "The AWS access key ID. Can also be set via the AWS_ACCESS_KEY_ID environment variable.")
	dryRun := flag.Bool("dry-run", false, "Print the actions that would be taken without uploading")
	showVersion := flag.Bool("version", false, "Print the version and exit")

	flag.Usage = func() {
		fmt.Fprintf(flag.CommandLine.Output(), "Usage of %s:\n", os.Args[0])
		flag.PrintDefaults()
		fmt.Println("\nNote: AWS_SECRET_ACCESS_KEY must also be set as an environment variable.")
	}

	flag.Parse()

	// Version mode
	if *showVersion {
		fmt.Println("s3-uploader", version)
		return
	}

	// Validate required parameters
	if *bucketName == "" {
		fmt.Println("Error: Missing bucket name.")
		flag.Usage()
		os.Exit(1)
	}
	if *filePath == "" {
		fmt.Println("Error: Missing file path.")
		flag.Usage()
		os.Exit(1)
	}
	if *region == "" {
		*region = os.Getenv("AWS_REGION")
		if *region == "" {
			fmt.Println("Error: Missing AWS region.")
			flag.Usage()
			os.Exit(1)
		}
	}
	if *accessKeyID == "" {
		*accessKeyID = os.Getenv("AWS_ACCESS_KEY_ID")
		if *accessKeyID == "" {
			fmt.Println("Error: Missing AWS access key ID.")
			flag.Usage()
			os.Exit(1)
		}
	}
	secretAccessKey := os.Getenv("AWS_SECRET_ACCESS_KEY")
	if secretAccessKey == "" {
		fmt.Println("Error: Missing AWS_SECRET_ACCESS_KEY environment variable.")
		flag.Usage()
		os.Exit(1)
	}

	// Check that the file exists and is not a directory
	fileInfo, err := os.Stat(*filePath)
	if err != nil {
		fmt.Println("Error: Could not access the file:", err)
		os.Exit(1)
	}
	if fileInfo.IsDir() {
		fmt.Println("Error: The specified path is a directory.")
		os.Exit(1)
	}

	// Build key for dry-run
	key := filepath.Base(*filePath)
	if *bucketFolder != "" {
		key = strings.Trim(*bucketFolder, "/") + "/" + key
	}

	// Masked Access Key
	maskedKey := *accessKeyID
	if len(maskedKey) > 4 {
		maskedKey = maskedKey[:4] + "****"
	}

	// Print parameters
	fmt.Print("\ns3-uploader will run with the following parameters:\n\n")
	fmt.Println("Bucket Name             :", *bucketName)
	fmt.Println("Bucket Folder Prefix    :", *bucketFolder)
	fmt.Println("File Path               :", *filePath)
	fmt.Printf("File size               : %.2f KB\n", float64(fileInfo.Size())/1024)
	fmt.Println("Region                  :", *region)
	fmt.Println("Access Key ID (masked)  :", maskedKey)
	fmt.Println("Secret Access Key Given :", len(secretAccessKey) > 0)
	fmt.Println("Dry Run                 :", *dryRun)
	fmt.Println("")

	if *dryRun {
		fmt.Printf("[dry-run] Would upload %s to s3://%s/%s\n", *filePath, *bucketName, key)
		return
	}

	// Upload
	if err := uploadFileToS3(*bucketName, *filePath, *bucketFolder, *region, *accessKeyID, secretAccessKey); err != nil {
		fmt.Fprintln(os.Stderr, "Error uploading file to S3:", err)
		os.Exit(1)
	}
}
