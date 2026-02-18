resource "aws_iam_role" "task_exec" {
    name = "${local.name}-exec"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "task_exec_service_role_policy" {
    role = aws_iam_role.task_exec.name
    # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}