resource "aws_ecs_task_definition" "api" {
    family = local.name
    network_mode = "bridge"
    execution_role_arn = aws_iam_role.task_exec.arn
    task_role_arn = aws_iam_role.task.arn
    container_definitions = templatefile("task-definition.tpl",
        {
            container_port = local.container_port
        }
    )
}