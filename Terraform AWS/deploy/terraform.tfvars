## provider.tf

#Required: AWS Region
aws_region = "us-east-1"

## end of provider.tf


## scenariotest module
resource_tag_name = "scenariotest"

namespace = "scenariotest"

#user_data = ""

ami_al2 = "ami-0ff8a91507f77f867"
instance_type_micro = "t2.micro"

ami_kali = "ami-01f9e4b812276174b"
instance_type_kali = "t2.medium"

ami_vuln_win = "ami-00a97929f99894c99"
instance_type_medium = "t2.medium"

iam_instance_profile = ""

key_name = "test1"

associate_public_ip_address = "1"

## end of scenariotest module