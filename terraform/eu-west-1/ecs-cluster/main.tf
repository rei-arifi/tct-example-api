resource "aws_cloudwatch_log_group" "cluster" {
    name = local.name
}

resource "aws_ecs_cluster" "cluster" {
    name = local.name
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = var.capacity_providers

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = var.capacity_providers[0]
  }
}