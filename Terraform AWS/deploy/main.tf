module "vpc" {
    source = "../modules/vpc"
}

module "ecs" {
    source = "../modules/ecs"
    Private_Blue_Subnet = module.vpc.Private_Blue_Subnet
    Blue_Team_Security_Group = module.vpc.Blue_Team_Security_Group
}

module "scenario1" {
    source = "../modules/scenario-vuln-ec2"
    Public_Subnet = module.vpc.Public_Subnet
    Public_Security_Group = module.vpc.Public_Security_Group
    Blue_Team_Security_Group = module.vpc.Blue_Team_Security_Group
    Red_Team_Security_Group = module.vpc.Red_Team_Security_Group
    Private_Blue_Subnet = module.vpc.Private_Blue_Subnet
    Private_Red_Subnet = module.vpc.Private_Red_Subnet
}