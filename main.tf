provider "aws" {
  region = "ap-south-1"  # Replace with your desired region
    profile = "default"     # Replace with your actual AWS profile if you want to use a named profile
    }

# Fetch details about the existing EC2 instance by its instance ID

data "aws_instance" "existing_instance" {
  instance_id = var.instance_id    # Variable that holds the instance ID
}

# Data source to retrieve the network interface associated with the instance
data "aws_network_interface" "instance_eni" {
  filter {
    name   = "attachment.instance-id"
    values = [data.aws_instance.existing_instance.id]
  }
}

# Attaching the new security group to the EC2 instance's primary network interface
resource "aws_network_interface_sg_attachment" "attach_sg" {
  security_group_id    = var.security_group_id  # The security group you want to attach
  network_interface_id = data.aws_network_interface.instance_eni.id
}

