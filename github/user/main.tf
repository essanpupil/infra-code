module "users" {
  for_each = var.usernames

  source = "git::https://github.com/essanpupil/infra-code.git//modules/github/user"

  username = each.value
  role     = var.role
}
