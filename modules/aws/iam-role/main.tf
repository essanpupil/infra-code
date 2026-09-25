data "aws_partition" "current" {}

resource "aws_iam_role" "this" {
  name                 = var.name
  path                 = var.path
  description          = var.description
  max_session_duration = var.max_session_duration

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "AllowConfiguredIamUsers"
      Effect = "Allow"
      Principal = {
        AWS = var.trusted_principal_arns
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
