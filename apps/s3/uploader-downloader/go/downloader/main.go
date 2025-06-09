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

func downloadFileFromS3(bucketName, objectKey, outputPath, region, accessKeyID, secretAccessKey string) error {
	// Create file to write
	file, err := os.Create(outputPath)
	if err != nil {
		return fmt.Errorf("failed to create output file %q: %w", outputPath, err)
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

	client := s3.NewFromConfig(cfg)
	downloader := manager.NewDownloader(client)

	// Download
	fmt.Printf("Downloading s3://%s/%s to %s\n", bucketName, objectKey, outputPath)
	_, err = downloader.Download(context.Background(), file, &s3.GetObjectInput{
		Bucket: &bucketName,
		Key:    &objectKey,
	})
	if err != nil {
		return fmt.Errorf("failed to download file from S3: %w", err)
	}

	fmt.Println("Download complete.")
	return nil
}

func main() {
	bucketName := flag.String("bucket", "", "The name of the S3 bucket to download from")
	bucketFolder := flag.String("bucket-folder", "", "Optional pseudo-folder (prefix) inside the S3 bucket")
	bucketFile := flag.String("bucket-file", "", "The name of the file to download (basename of the object)")
	localPath := flag.String("local-path", "", "The local downloaded file path (defaults to same name as file)")
	region := flag.String("region", "", "The AWS region. Can also be set via AWS_REGION")
	accessKeyID := flag.String("access-key-id", "", "The AWS access key ID. Can also be set via AWS_ACCESS_KEY_ID")
	dryRun := flag.Bool("dry-run", false, "Print the actions that would be taken without downloading")
	showVersion := flag.Bool("version", false, "Print the version and exit")

	flag.Usage = func() {
		fmt.Fprintf(flag.CommandLine.Output(), "Usage of %s:\n", os.Args[0])
		flag.PrintDefaults()
		fmt.Println("\nNote: AWS_SECRET_ACCESS_KEY must also be set as an environment variable.")
	}

	flag.Parse()

	if *showVersion {
		fmt.Println("s3-downloader", version)
		return
	}

	// Validate required parameters
	if *bucketName == "" {
		fmt.Println("Error: Missing bucket name.")
		flag.Usage()
		os.Exit(1)
	}
	if *bucketFile == "" {
		fmt.Println("Error: Missing bucket file name.")
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

	// Build S3 key
	objectKey := filepath.Base(*bucketFile)
	if *bucketFolder != "" {
		objectKey = strings.Trim(*bucketFolder, "/") + "/" + objectKey
	}

	// Determine output path
	outPath := *localPath
	if outPath == "" {
		outPath = filepath.Base(*bucketFile)
	}

	// Mask access key
	maskedKey := *accessKeyID
	if len(maskedKey) > 4 {
		maskedKey = maskedKey[:4] + "****"
	}

	// Print config
	fmt.Println("\ns3-downloader will run with the following parameters:")
	fmt.Println("Bucket Name             :", *bucketName)
	fmt.Println("Bucket Folder Prefix    :", *bucketFolder)
	fmt.Println("Object Key              :", objectKey)
	fmt.Println("Output Path             :", outPath)
	fmt.Println("Region                  :", *region)
	fmt.Println("Access Key ID (masked)  :", maskedKey)
	fmt.Println("Secret Access Key Given :", len(secretAccessKey) > 0)
	fmt.Println("Dry Run                 :", *dryRun)
	fmt.Println("")

	if *dryRun {
		fmt.Printf("[dry-run] Would download s3://%s/%s to %s\n", *bucketName, objectKey, outPath)
		return
	}

	// Perform download
	if err := downloadFileFromS3(*bucketName, objectKey, outPath, *region, *accessKeyID, secretAccessKey); err != nil {
		fmt.Fprintln(os.Stderr, "Error downloading file from S3:", err)
		os.Exit(1)
	}
}
