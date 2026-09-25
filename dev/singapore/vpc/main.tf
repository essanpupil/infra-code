module "vpc" {
  source = "../../../modules/aws/vpc"

  name               = "platform-dev"
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

  public_subnet_cidrs  = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  private_subnet_cidrs = ["10.0.64.0/20", "10.0.80.0/20", "10.0.96.0/20"]
  data_subnet_cidrs    = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]

  single_nat_gateway = true

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Purpose     = "shared-network"
  }
}
