terraform {
  backend "s3" {
    bucket = "terraform-artifactsz-bucket"
    key    = "cloudwatch-demo/terraform.tfstate"
    region = "us-east-1"
  }
}