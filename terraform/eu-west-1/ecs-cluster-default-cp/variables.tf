locals {
    name = "ecs-cluster-default-cp"
    ami_data = jsondecode(data.aws_ssm_parameter.ecs_ami.value)
    instance_profile_name = local.name
}

variable "ec2_key_name" {
    default = "eu-west-1"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "vpc_id" {
    default = "vpc-077ba288a4407d314"
}

variable "instance_security_groups" {
    default = [
        "sg-04d41568e49f51520", // public_ssh
        "sg-0321957c327eb6700", // balanced_instance
        "sg-00a5e0d0032cdebb0"  // egress
    ]
}

variable "instance_subnets" {
    default = [
        "subnet-03dae92d5a0e792d5", // tct-private-eu-west-1a
        "subnet-0906fad6df75177c6"  // tct-private-eu-west-1b
    ]
}

variable "ecs_cluster_name" {
    description = "Name of the ECS cluster to register instances with"
    default     = "example"
}