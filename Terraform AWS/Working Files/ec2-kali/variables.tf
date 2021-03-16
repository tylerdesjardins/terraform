## variables for ec2.tf

variable "resource_tag_name" {
    default = "scenariotest"
}

variable "namespace" {
    default = "scenariotest"
}
  
variable "iam_instance_profile" {
    default = ""
}

variable "key_name" {
    default = "test1"
}

variable "ami_kali" {
    default = "ami-01f9e4b812276174b"
}

variable "instance_type_kali" {
    default = "t2.medium"
}

## end variables for ec2.tf

## module variables
/*
variable "Public_Security_Group" {

}

variable "Private_Blue_Security_Group" {

}

variable "Private_Red_Security_Group" {

}

variable "Public_Subnet" {

}

variable "Private_Red_Subnet" {

}

variable "Private_Blue_Subnet" {

}
*/