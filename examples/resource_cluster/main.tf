terraform {
  required_providers {
    vmds = {
      source = "hashicorp.com/edu/vmds"
    }
  }
}

provider "vmds" {
  host      = "MDS_HOST_URL"
  api_token = "API_TOKEN"
}

locals {
  service_type       = "RABBITMQ"
  provider           = "aws"
  policy_with_create = ["open-to-all"]
  instance_type      = "XX-SMALL"
  region             = "eu-west-1"
}

data "vmds_network_policies" "create" {
  names = local.policy_with_create
}

output "network_policies_data" {
  value = {
    create = data.mds_network_policies.create
  }
}

resource "vmds_cluster" "test" {
  name               = "my-rmq-cls"
  service_type       = local.service_type
  cloud_provider     = local.provider
  instance_size      = local.instance_type
  region             = local.region
  network_policy_ids = data.mds_network_policies.create.policies[*].id
  tags               = ["mds-tf", "example", "new-tag"]
  timeouts           = {
    create = "10m"
  }
}