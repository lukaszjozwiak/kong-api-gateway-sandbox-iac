terraform {
  required_providers {
    kong = {
      source  = "kevholditch/kong"
      version = "6.5.0"
    }
  }
}

provider "kong" {
  kong_admin_uri = format("http://%s:8001", var.kong_instance_public_ip)
}
