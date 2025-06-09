# Makefile at the root of your project

BIN_DIR := bin

.PHONY: all build clean uploader downloader

all: build

build: uploader downloader

uploader:
	go build -o $(BIN_DIR)/s3-uploader ./uploader

downloader:
	go build -o $(BIN_DIR)/s3-downloader ./downloader

clean:
	rm -f $(BIN_DIR)/s3-uploader $(BIN_DIR)/s3-downloader
