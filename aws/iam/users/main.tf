# Create IAM groups module to be able to create IAM groups with specific policies attached.

resource aws_iam_user this {
  for_each = toset(var.users)
  name     = each.value
}

resource "aws_iam_user_login_profile" "this" {
  for_each                = toset(var.users)
  user                    = each.value
  password                = var.initial_password
  password_reset_required = true
}

