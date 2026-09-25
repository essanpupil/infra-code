resource "aws_iam_user" "this" {
  for_each = var.user_names

  name          = each.value
  path          = var.path
  force_destroy = var.force_destroy
  tags          = var.tags
}
