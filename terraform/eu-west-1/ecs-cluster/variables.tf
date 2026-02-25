locals {
  name = "example"
}

variable "capacity_providers" {
  // The first element of the list is the default provider
  default = [ "cp-ecs-cluster-default-cp" ]
}
