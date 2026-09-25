module "vpc" {
  source               = "git::https://github.com/essanpupil/infra-code.git//modules/aws/vpc"
  name                 = "platform-stg"
  vpc_cidr             = "10.1.0.0/16"
  availability_zones   = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnet_cidrs  = ["10.1.0.0/20", "10.1.16.0/20", "10.1.32.0/20"]
  private_subnet_cidrs = ["10.1.64.0/20", "10.1.80.0/20", "10.1.96.0/20"]
  data_subnet_cidrs    = ["10.1.128.0/20", "10.1.144.0/20", "10.1.160.0/20"]
  single_nat_gateway   = true
  tags = {
    Environment = "stg"
    ManagedBy   = "terraform"
    Purpose     = "shared-network"
  }
}
