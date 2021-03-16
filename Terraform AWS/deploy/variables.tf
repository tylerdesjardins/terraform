## variables for provider.tf

#Required: AWS Access Key
#variable "aws_access_key" {
#}

#Required: AWS Secret Key
#variable "aws_secret_key" {
#}

#Required: AWS Region
variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

## end variables for provider.tf


## variables for ec2.tf

variable "resource_tag_name" {
}

variable "namespace" {
}

variable "ami_al2" {
}

variable "instance_type_micro" {
}

variable "ami_vuln_win" {
}

variable "instance_type_medium" {
}

variable "iam_instance_profile" {
}

variable "key_name" {
}

variable "ami_kali" {
}

variable "instance_type_kali" {
}

variable "associate_public_ip_address" {
}

## end variables for ec2.tf