# Overview

Project is a sandbox for testing Kong API Gateway. It sets up Kong using AWS EC2 service. Infrastructure is spinned up with terraform.

# Setup 

## Prerequisites

* [AWS](https://aws.amazon.com) account with sufficient privileges. For sake of simplicity create [administrator account](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html) or use your `root` account. This project uses following AWS services:
    * [EC2](https://aws.amazon.com/ec2) - Only free tier resources are used.
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed locally. Project was tested with AWS CLI installed where [Terraform AWS provider](https://registry.terraform.io/providers/hashicorp/aws) uses `default` profile from `~/.aws` directory.
* Bash shell in order to run `curl` command.

## AWS

1. Go to IAM service, find your user and [create new API Access Key](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html)
2. [Configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) AWS CLI to use API key.

# Build

1. Go to project root directory
2. Run `terraform init`
3. Run `terraform apply -target="module.aws" -auto-approve` to create EC2 instance with running Kong.
4. Wait about 1 minute and run `terraform apply -auto-approve` to configure Kong. Wait period is required because Kong needs some time to warm up before it is ready to receive requests.

# Test 

Kong runs on EC2 instance with dynamic IP address, so you need to go to details of AWS EC2 instance named `Kong` and get its `Public IPv4 DNS` or `Public IPv4 address`. AWS Security Group is configured to allow inbound traffic on all ports.

Following configurations are applied to Kong, where `<PUBLIC_ADDRESS>` is AWS `Public IPv4 DNS` or `Public IPv4 address`:
1. Routing to `https://mockbin.org/` is configured under `http://<PUBLIC_ADDRESS>:8080/mock`
2. [Prometheus](https://docs.konghq.com/hub/kong-inc/prometheus/) plugin is installed. Metrics are available under `http://<PUBLIC_ADDRESS>:8081/metrics`

# Clean up

1. Run `terraform destroy -target="module.kong" -auto-approve`
2. Run `terraform destroy -target="module.aws" -auto-approve`
