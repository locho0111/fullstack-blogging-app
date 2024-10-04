variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "envirotnment" {
  type    = string
  default = "dev"
}

variable "aws_key_name" {
  type    = string
  default = "devops-key"
}

variable "aws_key_path" {
  type    = string
  default = "~/Desktop/AWS-keys/devops-key.pem"
}
