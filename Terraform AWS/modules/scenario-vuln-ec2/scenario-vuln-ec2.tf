#########################################################
## blue ec2-vuln-win
#########################################################

resource "aws_instance" "blue-ec2-vuln-win" {
  ami                         = var.ami_vuln_win
  instance_type               = var.instance_type_medium
  subnet_id                   = var.Private_Blue_Subnet
  associate_public_ip_address = "0"
  key_name                    = var.key_name
  vpc_security_group_ids      = var.Blue_Team_Security_Group
  tags = {
    Name = "blue-ec2-vuln-win"
  }
  iam_instance_profile = var.iam_instance_profile
}

#resource "aws_eip" "blue-ec2-vuln-win" {
#  vpc      = true
#  instance = aws_instance.blue-ec2-vuln-win.id
#}

#resource "tls_private_key" "blue-ec2-vuln-win" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

#resource "aws_key_pair" "blue-ec2-vuln-win" {
#  key_name   = var.key_name
#  public_key = tls_private_key.blue-ec2-vuln-win.public_key_openssh
#}

#########################################################
## kali
#########################################################

resource "aws_instance" "kali" {
  ami                         = var.ami_kali
  instance_type               = var.instance_type_kali
  subnet_id                   = var.Private_Red_Subnet
  associate_public_ip_address = "0"
  key_name                    = var.key_name
  vpc_security_group_ids      = var.Red_Team_Security_Group
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