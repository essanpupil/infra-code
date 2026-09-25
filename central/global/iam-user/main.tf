locals {
  dummy_user_names = toset([
    for index in range(1, 31) : format("dummy-user-%02d", index)
  ])
}

module "dummy_iam_users" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/iam-users"

  user_names = local.dummy_user_names
  tags = {
    ManagedBy = "terraform"
    Purpose   = "dummy-user"
  }
}
