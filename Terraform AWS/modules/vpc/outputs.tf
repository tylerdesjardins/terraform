output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.My_VPC.*.id, [""])[0]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.My_VPC.*.arn, [""])[0]
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(aws_vpc.My_VPC.*.cidr_block, [""])[0]
}

#output "subnet_id" {
#  value = [$aws_subnet.Private_Blue_Subnet.id]
#}

output "Public_Security_Group" {
  description = "Public Security Group"
  value = aws_security_group.Public_Security_Group.*.id
}

output "Blue_Team_Security_Group" {
  description = "Blue Team Security Group"
  value = aws_security_group.Blue_Team_Security_Group.*.id
}

output "Red_Team_Security_Group" {
  description = "Red Team Security Group"
  value = aws_security_group.Red_Team_Security_Group.*.id
}

output "Public_Subnet" {
  description = "Public Subnet"
  value = concat(aws_subnet.Public_Subnet.*.id, [""])[0]
}

output "Private_Red_Subnet" {
  description = "Private Red Subnet"
  value = concat(aws_subnet.Private_Red_Subnet.*.id, [""])[0]
}

output "Private_Blue_Subnet" {
  description = "Private Red Subnet"
  value = concat(aws_subnet.Private_Blue_Subnet.*.id, [""])[0]
}