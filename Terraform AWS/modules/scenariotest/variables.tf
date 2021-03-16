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

variable "ami_kali" {
    default = "ami-01f9e4b812276174b"
}

variable "instance_type_kali" {
    default = "t2.medium"
}

variable "associate_public_ip_address" {
    default = "1"
}

## end variables for ec2.tf

## module variables

variable "Public_Security_Group" {

}

variable "Blue_Team_Security_Group" {

}

variable "Red_Team_Security_Group" {

}

variable "Public_Subnet" {

}

variable "Private_Red_Subnet" {

}

variable "Private_Blue_Subnet" {

}
