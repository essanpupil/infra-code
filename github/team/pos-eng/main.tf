module "team" {
  source = "../../../modules/github/team"

  name        = "pos-eng"
  description = "POS engineering team"
  members     = { for username in var.usernames : username => "member" }
}
