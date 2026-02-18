locals {
    name = "ecs-cluster-default-cp"
    ami_data = jsondecode(data.aws_ssm_parameter.ecs_ami.value)
}

variable "ec2_key_name" {
    default = "eu-central-1"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "vpc_id" {
    default = "vpc-021f554deff076965"
}

variable "instance_security_groups" {
    default = [
        "sg-02ee674a6c020b846", // public_ssh
        "sg-04487b3319d5ccc22", // balanced_instance
        "sg-0348422414701963a"  // egress
    ]
}

variable "instance_subnets" {
    default = [
        "subnet-078dd95f6949246da", // tct-private-eu-central-1a
        "subnet-0e89e41b1d0c07ac0"  // tct-private-eu-central-1b
    ]
}

variable "ecs_cluster_name" {
    description = "Name of the ECS cluster to register instances with"
    default     = "example"
}