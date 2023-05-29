terraform {
  required_providers {
    vmds = {
      source = "vmware/managed-data-services"
    }
  }
}

provider "vmds" {
  host     = "MDS_HOST_URL"
  api_token = "API_TOKEN"
}

data "vmds_network_ports" "all" {
}

output "network_ports_data" {
  value = data.vmds_network_ports.all
}

