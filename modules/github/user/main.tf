resource "github_membership" "this" {
  username = var.username
  role     = var.role
}

resource "github_repository_collaborator" "this" {
  for_each = var.repository_permissions

  repository = each.key
  username   = var.username
  permission = each.value
}
