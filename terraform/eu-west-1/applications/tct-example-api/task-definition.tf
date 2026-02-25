resource "aws_ecs_task_definition" "api" {
    family = local.name
    network_mode = "bridge"
    execution_role_arn = local.iam_exec_role
    task_role_arn = local.iam_task_role
    container_definitions = templatefile("task-definition.tpl",
        {
            container_port = local.container_port
        }
    )
}