module "aws" {
  source = "./aws"
}

module "kong" {
  source                  = "./kong"
  kong_instance_public_ip = module.aws.kong_instance_public_ip
}
