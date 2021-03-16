###############################################
# vpc
###############################################

# Create VPC/Subnet/Security Group/Network ACL
# create the VPC
resource "aws_vpc" "S2_CTF" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
tags = {
    Name = "S2_CTF"
}
} # end resource

# create the Public, Private-Blue, and Private-Red Subnets
resource "aws_subnet" "Public_Subnet" {
  vpc_id                  = aws_vpc.S2_CTF.id
  cidr_block              = var.publicsubnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP 
#  availability_zone       = var.availabilityZone
tags = {
   Name = "Public_Subnet"
}
}

resource "aws_subnet" "Private_Subnet" {
  vpc_id                  = aws_vpc.S2_CTF.id
  cidr_block              = var.privatesubnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP 
#  availability_zone       = var.availabilityZone
tags = {
   Name = "Private_Subnet"
}
}
# end resource

# Create the Security Groups for Private and Public
resource "aws_security_group" "Private_Security_Group" {
  vpc_id       = aws_vpc.S2_CTF.id
  name         = "Private_Security_Group"
  description  = "Private_Security_Group"
  
# allow ingress for XXX
  ingress {
    cidr_blocks = var.redCIDRblock
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
   Name = "Private_Security_Group"
   Description = "Private_Security_Group"
}
}

resource "aws_security_group" "Public_Security_Group" {
  vpc_id       = aws_vpc.S2_CTF.id
  name         = "Public_Security_Group"
  description  = "Public_Security_Group"
  
  # allow ingress of vpn
  ingress {
    cidr_blocks = var.vpnCIDRblock  
    from_port   = 0
    to_port     = 0
    description = "All"
    protocol    = "-1"
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
} 
# end resource

# create VPC Network access control list
resource "aws_network_acl" "S2_CTF_Security_ACL" {
  vpc_id = aws_vpc.S2_CTF.id
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
    Name = "S2_CTF_ACL"
}
} 
# end resource

# Create the Internet Gateway
resource "aws_internet_gateway" "S2_CTF_GW" {
 vpc_id = aws_vpc.S2_CTF.id
 tags = {
        Name = "S2_CTF_Internet_Gateway"
}
} 

resource "aws_eip" "nat" {
  vpc      = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.Public_Subnet.id

  tags = {
    Name = "S2_CTF_NAT_Gateway"
  }
}
 # end resource

# Create the Route Table
resource "aws_route_table" "S2_CTF_route_table" {
 vpc_id = aws_vpc.S2_CTF.id
 tags = {
        Name = "S2_CTF_Route_Table"
}
}
# end resource

# Create the Internet Access
resource "aws_route" "S2_CTF_internet_access" {
  route_table_id         = aws_route_table.S2_CTF_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  nat_gateway_id             = aws_nat_gateway.gw.id
} 
# end resource

# Associate the Route Table with the Subnets
/*resource "aws_route_table_association" "S2_CTF_public_association" {
  subnet_id      = aws_subnet.Public_Subnet.id
  route_table_id = aws_route_table.S2_CTF_route_table.id
}
*/

resource "aws_route_table_association" "S2_CTF_private_association" {
  subnet_id      = aws_subnet.Private_Subnet.id
  route_table_id = aws_route_table.S2_CTF_route_table.id
}
# end resource

###############################################
# end vpc
###############################################