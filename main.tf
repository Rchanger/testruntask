resource "aws_instance" "this" {
  ami           = "ami-674cbc1e"
  instance_type = "m5.8xlarge"

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "data"
    volume_type = "io1"
    volume_size = 1000
    iops        = 800
  }
  monitoring           = true
  iam_instance_profile = "<valid_iam_role>"

  metadata_options {
    http_endpoint = "disabled"
    http_tokens   = "required"
  }

  tags {
    Name = "<instance_name>"
  }
}

resource "aws_lambda_function" "this" {
  function_name = "hello_world"
  role          = "arn:aws:lambda:us-east-1:account-id:resource-id"
  handler       = "exports.test"
  runtime       = "nodejs12.x"
  memory_size   = 1024

  vpc_config {
    security_group_ids = ["<valid_security_group_ids>"]
    subnet_ids         = ["<valid_subnet_ids>"]
  }

  tracing_config {
    mode = "Active"
  }
}

resource "aws_vpc" "<resource_name>" {
  cidr_block = "<cidr>"

  tags = {
    Name = "main"
  }
}