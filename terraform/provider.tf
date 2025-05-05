provider "aws" {
  region     = var.region
}

terraform {
  backend "s3" {
    bucket = "ahmed-magdy-iti"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

