# Name of the security group
name = "my-security-group"

# Description of the security group
description = "Security group for web servers"

# The VPC ID where the security group will be created
vpc_id = "vpc-0a7f38e7fa065457d"

# Ingress rules (allowing incoming traffic)
ingress_rules = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP traffic from anywhere
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24"]  # Allow SSH traffic only from a specific subnet
  }
]

# Egress rules (allowing outgoing traffic)
egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
]

# Tags for the security group
tags = {
  Name = "my-security-group"
  Environment = "production"
}
