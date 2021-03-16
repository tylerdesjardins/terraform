###############################################
# vpc
###############################################

# Create VPC/Subnet/Security Group/Network ACL
# create the VPC
resource "aws_vpc" "My_VPC" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
tags = {
    Name = "My VPC"
}
} # end resource

# create the Public, Private-Blue, and Private-Red Subnets
resource "aws_subnet" "Public_Subnet" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.publicsubnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP 
#  availability_zone       = var.availabilityZone
tags = {
   Name = "Public Subnet"
}
}

resource "aws_subnet" "Private_Blue_Subnet" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.privatebluesubnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP 
#  availability_zone       = var.availabilityZone
tags = {
   Name = "Private-Blue Subnet"
}
}

resource "aws_subnet" "Private_Red_Subnet" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.privateredsubnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP 
#  availability_zone       = var.availabilityZone
tags = {
   Name = "Private-Red Subnet"
}
}

# end resource
# Create the Security Groups for Red Team, Blue Team, and Public
resource "aws_security_group" "Blue_Team_Security_Group" {
  vpc_id       = aws_vpc.My_VPC.id
  name         = "Blue_Team_Security_Group"
  description  = "Blue_Team_Security_Group"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.bastionCIDRblock
    from_port   = 22
    to_port     = 22
    description = "SSH"
    protocol    = "tcp"
  } 

# allow ingress for vpn
  ingress {
    cidr_blocks = var.vpnCIDRblock
    from_port   = 0
    to_port     = 00
    description = "All"
    protocol    = "-1"
  } 

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
   Name = "Blue_Team_Security_Group"
   Description = "Blue_Team_Security_Group"
}
}

resource "aws_security_group" "Red_Team_Security_Group" {
  vpc_id       = aws_vpc.My_VPC.id
  name         = "Red_Team_Security_Group"
  description  = "Red_Team_Security_Group"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.bastionCIDRblock  
    from_port   = 22
    to_port     = 22
    description = "SSH"
    protocol    = "tcp"
  } 

# allow ingress for vpn
  ingress {
    cidr_blocks = var.vpnCIDRblock
    from_port   = 0
    to_port     = 0
    description = "All"
    protocol    = "-1"
  }

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
   Name = "Red_Team_Security_Group"
   Description = "Red_Team_Security_Group"
}
}

resource "aws_security_group" "Public_Security_Group" {
  vpc_id       = aws_vpc.My_VPC.id
  name         = "Public_Security_Group"
  description  = "Public_Security_Group"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 22
    to_port     = 22
    description = "SSH"
    protocol    = "tcp"
  } 
  
  # allow egress of all ports
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24","10.0.3.0/24"]
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
   Name = "Public_Security_Group"
   Description = "Public_Security_Group"
}

} # end resource
# create VPC Network access control list
resource "aws_network_acl" "My_VPC_Security_ACL" {
  vpc_id = aws_vpc.My_VPC.id
  subnet_ids = [ aws_subnet.Public_Subnet.id ]
# allow ingress port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock 
    from_port  = 22
    to_port    = 22
  }
  
  /*
  # allow ingress port 80 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.destinationCIDRblock 
    from_port  = 80
    to_port    = 80
  }
  */

  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 0
    to_port    = 65535
  }
  
  # allow egress ssh
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 22 
    to_port    = 22
  }
  
/*
  # allow egress port 80 
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 80  
    to_port    = 80 
  }
*/ 

  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 0
    to_port    = 65535
  }
tags = {
    Name = "My VPC ACL"
}
} # end resource
# Create the Internet Gateway
resource "aws_internet_gateway" "My_VPC_GW" {
 vpc_id = aws_vpc.My_VPC.id
 tags = {
        Name = "My VPC Internet Gateway"
}
} # end resource
# Create the Route Table
resource "aws_route_table" "My_VPC_route_table" {
 vpc_id = aws_vpc.My_VPC.id
 tags = {
        Name = "My VPC Route Table"
}
} # end resource
# Create the Internet Access
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = aws_route_table.My_VPC_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.My_VPC_GW.id
} # end resource

# Associate the Route Table with the Subnets
resource "aws_route_table_association" "My_VPC_public_association" {
  subnet_id      = aws_subnet.Public_Subnet.id
  route_table_id = aws_route_table.My_VPC_route_table.id
}

resource "aws_route_table_association" "My_VPC_privateblue_association" {
  subnet_id      = aws_subnet.Private_Blue_Subnet.id
  route_table_id = aws_route_table.My_VPC_route_table.id
}

resource "aws_route_table_association" "My_VPC_privatered_association" {
  subnet_id      = aws_subnet.Private_Red_Subnet.id
  route_table_id = aws_route_table.My_VPC_route_table.id
} 

# end resource

###############################################
# end vpc
###############################################