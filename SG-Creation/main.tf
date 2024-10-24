provider "aws" {
  region  = "ap-south-1" # Replace with your desired region
  profile = "default"    # Replace with your actual AWS profile if you want to use a named profile


}


# Sourcing a Terraform module from GitHub
module "Test_module" {
  source = "github.com/oberoi1984/terraform-module-test/SG-Creation"
  #source = "git@github.com:oberoi1984/terraform-module-test.git"
  name          = var.name
  description   = var.description
  vpc_id        = var.vpc_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
  tags          = var.tags

}
