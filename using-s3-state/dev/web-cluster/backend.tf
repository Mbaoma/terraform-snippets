terraform {
  backend "s3" {
    bucket         = "jumpingd1n05aurs"
    key            = "using-s3-webserver/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "jumpingd1n05aurs-table"
    encrypt        = true
  }
}  