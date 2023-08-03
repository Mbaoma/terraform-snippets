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
  default     = "chapter-2-instance-sg"
}

variable "alb_security_group_name" {
  description = "The name of the security group for the ALB"
  type        = string
  default     = "chapter-2-alb-sg"
}

variable "ami" {
  default = "ami-0f8e81a3da6e2510a"
}

variable "instance_type" {
  default = "t2.micro"
}