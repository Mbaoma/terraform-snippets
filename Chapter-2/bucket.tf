terraform {
  backend "s3" {
    bucket = "terraform-snippet569gh"
    key    = "chapter-2/infra-task.tfstate"
    region = "us-west-1"
  }
}