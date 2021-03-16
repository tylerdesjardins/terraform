#########################################################
## bastion
#########################################################

resource "aws_instance" "bastion-ec2-amazon-linux-2" {
  ami                         = var.ami_al2
  instance_type               = var.instance_type_micro
  subnet_id                   = var.Public_Subnet
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  vpc_security_group_ids      = var.Public_Security_Group
  #vpc_security_group_ids      = var.vpc_security_group_ids
  tags = {
    Name = "bastion-ec2-amazon-linux-2"
  }
  iam_instance_profile = var.iam_instance_profile
}

resource "aws_eip" "bastion-ec2-amazon-linux-2" {
  vpc      = true
  instance = aws_instance.bastion-ec2-amazon-linux-2.id
}

#resource "tls_private_key" "bastion-ec2-amazon-linux-2" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

#resource "aws_key_pair" "bastion-ec2-amazon-linux-2" {
#  key_name   = var.key_name
#  public_key = tls_private_key.bastion-ec2-amazon-linux-2.public_key_openssh
#}
