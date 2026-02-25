data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended"
}

resource "aws_launch_template" "lt" {
  name                   = local.name
  image_id               = local.ami_data.image_id
  instance_type          = var.instance_type
  update_default_version = true
  instance_initiated_shutdown_behavior = "terminate"

#   block_device_mappings {
#     device_name = "/dev/xvda"
#     ebs { volume_size = 30 }
#   }

#   ebs_optimized = true

  iam_instance_profile {
    name = local.instance_profile_name
  }
  key_name = var.ec2_key_name

  vpc_security_group_ids = var.instance_security_groups

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 3
    instance_metadata_tags      = "enabled"
  }

  monitoring { 
    enabled = true 
    }

  private_dns_name_options { enable_resource_name_dns_a_record = false }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = local.name
      Terraform = "true"
    }
  }

  user_data = base64encode(templatefile("./userdata.tpl", {
    ecs_cluster_name        = var.ecs_cluster_name
  }))
}