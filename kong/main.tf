# resource "kong_service" "kong" {
#   name     = "example"
#   protocol = "http"
#   host     = "example"
#   port     = 6555
#   retries  = 5
# }

# resource "kong_route" "example-route" {
#   name                       = "example-route"
#   protocols                  = ["https"]
#   hosts                      = ["api.example.com"]
#   paths                      = ["/"]
#   https_redirect_status_code = 301
#   strip_path                 = false
#   preserve_host              = true
#   service_id                 = kong_service.example.id
# }

resource "kong_plugin" "prometheus" {
  name = "prometheus"
}
