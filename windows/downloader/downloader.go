package main

import (
    "log"
    "io"
    "os"
    "strings"
    "encoding/json"
    "github.com/aws/aws-sdk-go/aws"
    "github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
)

type configuration struct {
	PackagesDir string
	Bucket string
	KeyBase string
	Packages []string
}

func getConfig() *Configuration {
	file, _ := os.Open("config.json")
	decoder := json.NewDecoder(file)
	config := configuration{}
	err := decoder.Decode(&config)

	if err != nil {
		log.Fatal(err)
	}

	return &config
}

func download(region, bucket, packageKey, output string) {
	sess := session.New()
	svc := s3.New(sess, aws.NewConfig().WithRegion(region))

	results, err := svc.GetObject(&s3.GetObjectInput{
		Bucket: aws.String(Bucket),
		Key: aws.String(package_key),
	})

	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

	defer results.Body.Close()

    packageFile, err := os.Create(output)	
    
    if err != nil {
    	log.Fatal("Failed to create file", err)
    }

    defer packageFile.Close()

	if _, err := io.Copy(packageFile, results.Body); err != nil {
		log.Fatal(err)		
	}
}

func createPackageDir(packagesDir string) error {
	if _, err := os.Stat(packagesDir); err != nil {
        if os.IsNotExist(err) {
            err := os.Mkdir(packagesDir, 0777)
            log.Fatal(err)
            return err
        }
    }
    return nil
}

func main() {
	config := getConfig()

    err := createPackageDir(config.PackagesDir)
    if err != nil {
    	log.Fatal(err)
    }

    for _, v := range config.Packages {
		packageKey := strings.Join([]string{config.KeyBase, v}, "/")
        output := strings.Join([]string{config.PackagesDir, v}, "/")

        log.Printf("Downloading %v", v)
		download(config.Region, config.Bucket, packageKey, output)
	}
}