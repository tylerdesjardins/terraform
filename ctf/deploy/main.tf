module "vpc" {
    source = "../modules/vpc"
}

module "ecs-ctf-app" {
    source = "../modules/ecs-ctf-app"
    Private_Subnet = module.vpc.Private_Subnet
    Private_Security_Group = module.vpc.Private_Security_Group
}

module "ecs-ctf-dashboard" {
    source = "../modules/ecs-ctf-dashboard"
    Private_Subnet = module.vpc.Private_Subnet
    Private_Security_Group = module.vpc.Private_Security_Group
}