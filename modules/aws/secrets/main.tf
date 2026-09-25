resource "random_password" "this" {
  length           = var.password_length
  special          = true
  override_special = var.override_special
}

resource "aws_secretsmanager_secret" "this" {
  name                    = var.name
  description             = var.description
  recovery_window_in_days = var.recovery_window_in_days
  kms_key_id              = var.kms_key_id
  tags                    = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(merge(var.secret_data, {
    password = random_password.this.result
  }))
}

data "aws_iam_policy_document" "read_policy" {
  count = length(var.allowed_principal_arns) == 0 ? 0 : 1

  statement {
    sid    = "AllowSecretRead"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = tolist(var.allowed_principal_arns)
    }

    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
    ]

    resources = [aws_secretsmanager_secret.this.arn]
  }

  statement {
    sid    = "DenySecretReadExceptAllowedPrincipals"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
    ]

    resources = [aws_secretsmanager_secret.this.arn]

    condition {
      test     = "ArnNotEquals"
      variable = "aws:PrincipalArn"
      values   = tolist(var.allowed_principal_arns)
    }
  }
}

resource "aws_secretsmanager_secret_policy" "this" {
  count      = length(var.allowed_principal_arns) == 0 ? 0 : 1
  secret_arn = aws_secretsmanager_secret.this.arn
  policy     = data.aws_iam_policy_document.read_policy[0].json
}
