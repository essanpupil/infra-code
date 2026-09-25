module "vpc" {
  source               = "git::https://github.com/essanpupil/infra-code.git//modules/aws/vpc"
  name                 = "platform-prod"
  vpc_cidr             = "10.2.0.0/16"
  availability_zones   = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnet_cidrs  = ["10.2.0.0/20", "10.2.16.0/20", "10.2.32.0/20"]
  private_subnet_cidrs = ["10.2.64.0/20", "10.2.80.0/20", "10.2.96.0/20"]
  data_subnet_cidrs    = ["10.2.128.0/20", "10.2.144.0/20", "10.2.160.0/20"]
  single_nat_gateway   = false
  tags = {
    Environment = "prod"
    ManagedBy   = "terraform"
    Purpose     = "shared-network"
  }
}
