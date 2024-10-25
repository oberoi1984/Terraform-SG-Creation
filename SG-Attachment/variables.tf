variable "instance_id" {
  description = "Instance ID"
  type = string
  
}

variable "security_group_id" {
  description = "List of security group IDs to attach"
  type        = string
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default     = {}
}

