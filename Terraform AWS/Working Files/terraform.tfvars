#profile = "hackathon"

aws_region = "us-east-1"

#resource_tag_name = "shieldandsword"

#namespace = "shieldandsword"

#user_data = ""

#subnet_id = ""

associate_public_ip_address = "1"

#vpc_security_group_ids = "${local.resource_name_prefix}-blue-sg"

#key_name = ""

#Required: AWS Access Key
aws_access_key = "ENTER HERE"

#Required: AWS Secret Key
aws_secret_key = "ENTER HERE"

#vpc_security_group_ids = "${local.resource_name_prefix}-blue-sg"

resource_tag_name = "blueteam"

namespace = "blueteam"

#user_data = ""

ami = "ami-0ff8a91507f77f867"
instance_type = "t2.micro"

ami_kali = "ami-01f9e4b812276174b"
instance_type_kali = "t2.medium"

iam_instance_profile = ""

key_name = "test1"

## iam.tf

#iam_users = ["babu.khadiranaikar","constantine.grantcharov","cuong.lieu","jason.erickson"]