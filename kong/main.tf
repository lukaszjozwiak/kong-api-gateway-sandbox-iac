resource "kong_plugin" "prometheus" {
  name = "prometheus"
}

resource "kong_service" "mockbin" {
  name     = "mockbin"
  protocol = "https"
  host     = "mockbin.org"
  port     = 443
  path     = "/"
}

resource "kong_route" "mockbin-route" {
  name       = "mockbin-route"
  protocols  = ["http", "https"]
  paths      = ["/"]
  service_id = kong_service.mockbin.id
}
