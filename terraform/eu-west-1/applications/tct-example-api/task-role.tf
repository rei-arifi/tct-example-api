# IAM Roles are managed in the default region eu-central-1

# resource "aws_iam_role" "task" {
#     name = "${local.name}-task"
#     assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         }
#       },
#     ]
#   })
# }
