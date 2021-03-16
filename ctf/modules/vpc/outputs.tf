output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.S2_CTF.*.id, [""])[0]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.S2_CTF.*.arn, [""])[0]
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(aws_vpc.S2_CTF.*.cidr_block, [""])[0]
}

#output "subnet_id" {
#  value = [$aws_subnet.Private_Subnet.id]
#}

output "Public_Security_Group" {
  description = "Public Security Group"
  value = aws_security_group.Public_Security_Group.*.id
}

output "Private_Security_Group" {
  description = "Blue Team Security Group"
  value = aws_security_group.Private_Security_Group.*.id
}

output "Public_Subnet" {
  description = "Public Subnet"
  value = concat(aws_subnet.Public_Subnet.*.id, [""])[0]
}

output "Private_Subnet" {
  description = "Private Subnet"
  value = concat(aws_subnet.Private_Subnet.*.id, [""])[0]
}