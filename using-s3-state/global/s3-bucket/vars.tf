variable "bucket_name" {
  description = "Name of bucket that will store state files"
  type        = string
  default     = "jumpingd1n05aurs"
}

variable "table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "jumpingd1n05aurs-table"
}