variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
  default     = "alb"
}

variable "instance_security_group_name" {
  description = "The name of the security group for the EC2 Instances"
  type        = string
  default     = "chapter-3-instance-sg"
}

variable "alb_security_group_name" {
  description = "The name of the security group for the ALB"
  type        = string
  default     = "chapter-3-alb-sg"
}

variable "ami" {
  default = "ami-0f8e81a3da6e2510a"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket used for the database's remote state storage"
  type        = string
  default     = "jumpingd1n05aurs"
}

variable "db_remote_state_key" {
  description = "The name of the key in the S3 bucket used for the database's remote state storage"
  type        = string
  default     = "using-s3/terraform.tfstate"
}
