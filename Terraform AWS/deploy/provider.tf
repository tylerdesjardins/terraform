# provider.tf

# Specify the provider and access details
provider "aws" {
  profile                 = "default"
  region                  = var.aws_region
  shared_credentials_file = "~/.aws/credentials"
}