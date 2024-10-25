# Terraform Security Group Module

This Terraform project creates a configurable AWS security group using a modular approach. The `CreateSG` module can be reused and customized to define ingress and egress rules for secure and organized AWS environment management.

## Project Structure

### Files

- **outer main.tf**: Configures the AWS provider and calls the `CreateSG` module with custom parameters.
- **module/CreateSG**: Contains the actual Terraform files to define the AWS security group.

### Module Files in `CreateSG`

- **main.tf**: The core logic for creating an AWS security group with dynamic ingress and egress rules.
- **variables.tf**: Declares variables to define the security group's name, VPC ID, ingress and egress rules, and tags.

## Requirements

- Terraform 0.12+
- AWS CLI configured with a profile if using named profiles (`default` in this example)
- AWS credentials with permissions to create security groups

## Usage

### Provider Configuration

The AWS provider is set up in the `outer main.tf` file:
```hcl
provider "aws" {
    region  = "ap-south-1"
    profile = "default"  # AWS named profile
}
module "CreateSG" {
  source = "./module/CreateSG"
  vpc_id = "vpc-0a7f38e7fa065457d"
  name = "Terraform-SG"
  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allows HTTP access from anywhere
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["192.168.1.0/24"]  # Allows SSH access from a specific subnet
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"  # Allows all outbound traffic
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = {
    Name = "my-security-group"
    Environment = "production"
  }
}

## main.tf: Contains the aws_security_group resource to create a security group in AWS. It uses dynamic blocks to define ingress and egress rules based on input variables.

provider "aws" {
  region  = "ap-south-1" # Replace with your desired region
  profile = "default"    # Replace with your actual AWS profile if you want to use a named profile
}

resource "aws_security_group" "custom_sg" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = var.tags
}

## variables.tf: Declares all the required variables for the module, including name, description, vpc_id, ingress_rules, egress_rules, and tags.

variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Security group for resource"
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {}
}

