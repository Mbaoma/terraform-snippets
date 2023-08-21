variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
  default     = "may"
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
  default     = "flippingtab13se"
}

variable "db_name" {
  description = "The name to use for the database"
  type        = string
  default     = "practice_s3"
}