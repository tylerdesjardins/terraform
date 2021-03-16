## variables for ec2.tf

variable "resource_tag_name" {
    default = "scenariotest"
}

variable "namespace" {
    default = "scenariotest"
}

variable "ami_al2" {
    default = "ami-0ff8a91507f77f867"
}

variable "instance_type_micro" {
    default = "t2.micro"
}
  
variable "iam_instance_profile" {
    default = ""
}

variable "key_name" {
    default = "test1"
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