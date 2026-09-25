module "team" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/github/team"

  name        = "pos-eng"
  description = "POS engineering team"
  members     = { for username in var.usernames : username => "member" }
}
