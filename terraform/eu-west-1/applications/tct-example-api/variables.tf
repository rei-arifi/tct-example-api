data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
    name = "tct-example-api"
    cluster_name = "example"
    vpc_id = "vpc-077ba288a4407d314"
    container_port = 3000
    iam_task_role = "arn:aws:iam::${local.account_id}:role/${local.name}-task"
    iam_exec_role = "arn:aws:iam::${local.account_id}:role/${local.name}-exec"
    acm_cert = "arn:aws:acm:eu-west-1:567653862007:certificate/226e6ff4-ea62-45a6-99e2-eecda467c1dd"
}