#########################################################
## kali
#########################################################

resource "aws_instance" "kali" {
  ami                         = var.ami_kali
  instance_type               = var.instance_type_kali
  subnet_id                   = var.Private_Red_Subnet
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  vpc_security_group_ids      = var.Red_Team_Security_Group
  #vpc_security_group_ids      = var.vpc_security_group_ids
  tags = {
    Name = "kali"
  }
  iam_instance_profile = var.iam_instance_profile
}

#resource "aws_eip" "kali" {
#  vpc      = true
#  instance = aws_instance.kali.id
#}

#resource "tls_private_key" "kali" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

#resource "aws_key_pair" "kali" {
#  key_name   = var.key_name
#  public_key = tls_private_key.kali.public_key_openssh
#}