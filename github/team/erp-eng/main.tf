module "team" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/github/team"

  name        = "erp-eng"
  description = "ERP engineering team"
  members     = { for username in var.usernames : username => "member" }
}
