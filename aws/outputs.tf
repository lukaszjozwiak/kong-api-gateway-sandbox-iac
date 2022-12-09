output "kong_instance_public_ip" {
  value = aws_instance.kong.public_ip
}
