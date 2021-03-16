###############################################
# start ec2
###############################################
resource "aws_instance" "blue-ec2-amazon-linux-2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.Private_Blue_Subnet.id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.Blue_Team_Security_Group.id]
  #vpc_security_group_ids      = var.vpc_security_group_ids
  tags = {
    Name = "blue-ec2-amazon-linux-2"
  }
  iam_instance_profile = var.iam_instance_profile
}

#resource "aws_eip" "blue-ec2-amazon-linux-2" {
#  vpc      = true
#  instance = aws_instance.blue-ec2-amazon-linux-2.id
#}

#resource "tls_private_key" "blue-ec2-amazon-linux-2" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

#resource "aws_key_pair" "blue-ec2-amazon-linux-2" {
#  key_name   = var.key_name
#  public_key = tls_private_key.blue-ec2-amazon-linux-2.public_key_openssh
#}

resource "aws_instance" "red-ec2-amazon-linux-2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.Private_Red_Subnet.id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.Red_Team_Security_Group.id]
  #vpc_security_group_ids      = var.vpc_security_group_ids
  tags = {
    Name = "red-ec2-amazon-linux-2"
  }
  iam_instance_profile = var.iam_instance_profile
}

#resource "aws_eip" "red-ec2-amazon-linux-2" {
#  vpc      = true
#  instance = aws_instance.red-ec2-amazon-linux-2.id
#}

#resource "tls_private_key" "red-ec2-amazon-linux-2" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

#resource "aws_key_pair" "red-ec2-amazon-linux-2" {
#  key_name   = var.key_name
#  public_key = tls_private_key.red-ec2-amazon-linux-2.public_key_openssh
#}

resource "aws_instance" "bastion-ec2-amazon-linux-2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.Public_Subnet.id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.Public_Security_Group.id]
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

resource "aws_instance" "kali" {
  ami                         = var.ami_kali
  instance_type               = var.instance_type_kali
  subnet_id                   = aws_subnet.Private_Red_Subnet.id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.Red_Team_Security_Group.id]
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

#########################################################
## bastion
#########################################################

resource "aws_instance" "bastion-ec2-win" {
  ami                         = var.ami_vuln_win
  instance_type               = var.instance_type_micro
  subnet_id                   = var.Public_Subnet
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  vpc_security_group_ids      = var.Public_Security_Group
  #vpc_security_group_ids      = var.vpc_security_group_ids
  tags = {
    Name = "bastion-ec2-win
  "
  }
  iam_instance_profile = var.iam_instance_profile
}

resource "aws_eip" "bastion-ec2-win" {
  vpc      = true
  instance = aws_instance.bastion-ec2-win
.id
}

#resource "tls_private_key" "bastion-ec2-win" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

#resource "aws_key_pair" "bastion-ec2-win" {
#  key_name   = var.key_name
#  public_key = tls_private_key.bastion-ec2-win.public_key_openssh
#}

#########################################################
## blue ec2
#########################################################

resource "aws_instance" "blue-ec2-win" {
  ami                         = var.ami_al2
  instance_type               = var.instance_type_micro
  subnet_id                   = var.Private_Blue_Subnet
  associate_public_ip_address = "0"
  key_name                    = var.key_name
  vpc_security_group_ids      = var.Blue_Team_Security_Group
  tags = {
    Name = "blue-ec2-win
  "
  }
  iam_instance_profile = var.iam_instance_profile
}

#resource "aws_eip" "blue-ec2-win" {
#  vpc      = true
#  instance = aws_instance.blue-ec2-win.id
#}

#resource "tls_private_key" "blue-ec2-win" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

#resource "aws_key_pair" "blue-ec2-win" {
#  key_name   = var.key_name
#  public_key = tls_private_key.blue-ec2-win.public_key_openssh
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