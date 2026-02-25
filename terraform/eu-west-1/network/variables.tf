locals {
    name = "tct"
    vpc_cidr_range = "10.20.0.0/16"
    azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
    private_subnets = ["10.20.10.0/24", "10.20.20.0/24", "10.20.30.0/24"]
    public_subnets  = ["10.20.110.0/24", "10.20.120.0/24", "10.20.130.0/24"]

}