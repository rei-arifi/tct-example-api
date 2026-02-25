# IAM Roles are managed on the main region: eu-central-1

# resource "aws_iam_role" "instance" {
#     name = local.name
#     assume_role_policy = jsonencode({
#         Version = "2012-10-17",
#         Statement = [{
#           Action = "sts:AssumeRole",
#           Effect = "Allow",
#           Sid    = "",
#           Principal = { Service = "ec2.amazonaws.com" }
#         }]
#     })
# }

# resource "aws_iam_role_policy_attachment" "container_service_ec2_policy" {
#   role       = aws_iam_role.instance.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
# }

# resource "aws_iam_instance_profile" "instance" {
#     name = local.name
#     role = aws_iam_role.instance.name
# }
