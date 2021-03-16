## variables for vpc.tf

#variable "profile" {    
#}
 
#variable "subnet_id" {
#}

#variable "associate_public_ip_address" {
#}

#variable "vpc_security_group_ids" {
#}

variable "instanceTenancy" {
    default = "default"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}
variable "publicsubnetCIDRblock" {
    default = "10.0.1.0/24"
}
variable "privatesubnetCIDRblock" {
    default = "10.0.2.0/24"
}
variable "destinationCIDRblock" {
    default = "0.0.0.0/0"
}
variable "defaultCIDRblock" {
    default = ["0.0.0.0/0"]
}
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "bastionCIDRblock" {
    type = list
    default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}
variable "vpnCIDRblock" {
    type = list
    default = [ "192.168.252.0/22", "10.0.0.0/8" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "mapPublicIP" {
    default = true
}
## end variables for vpc.tf