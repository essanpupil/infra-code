module "users" {
  for_each = var.usernames

  source = "../../modules/github/user"

  username = each.value
  role     = var.role
}
