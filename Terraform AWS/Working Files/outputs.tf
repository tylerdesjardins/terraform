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

#output "key_name" {
#  value = aws_key_pair.red-ec2-amazon-linux-2.key_name
#}

#output "public_key_openssh" {
#  value = tls_private_key.red-ec2-amazon-linux-2.public_key_openssh
#}

#output "private_key_pem" {
#  value = tls_private_key.red-ec2-amazon-linux-2.private_key_pem
#}

## iam.tf

#output "this_iam_user_name" {
#  description = "The user's name"
#  value       = element(concat(aws_iam_user.iam_user.*.name, [""]), 0)
#}##

#output "this_iam_user_arn" {
#  description = "The ARN assigned by AWS for this user"
#  value       = element(concat(aws_iam_user.iam_user.*.arn, [""]), 0)
#}

#output "this_iam_user_unique_id" {
#  description = "The unique ID assigned by AWS"
#  value       = element(concat(aws_iam_user.iam_user.*.unique_id, [""]), 0)
#}

#output "this_iam_user_login_profile_key_fingerprint" {
#  description = "The fingerprint of the PGP key used to encrypt the password"
#  value = element(
#    concat(aws_iam_user_login_profile.login_profile.*.key_fingerprint, [""]),
#    0,
#  )
#}

#output "this_iam_user_login_profile_encrypted_password" {
#  description = "The encrypted password, base64 encoded"
#  value = element(
#    concat(aws_iam_user_login_profile.login_profile.*.encrypted_password, [""]),
#    0,
#  )
#}