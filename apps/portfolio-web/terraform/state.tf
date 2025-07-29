terraform {
  backend "s3" {
    bucket         = "916756353715-terraform-state"
    key            = "portfolio-web/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "916756353715-terraform-state-locks"
    encrypt        = true
  }
}
