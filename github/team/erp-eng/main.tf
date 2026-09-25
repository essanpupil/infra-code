module "team" {
  source = "../../../modules/github/team"

  name        = "erp-eng"
  description = "ERP engineering team"
  members     = { for username in var.usernames : username => "member" }
}
