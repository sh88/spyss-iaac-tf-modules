# Create IAM groups module to be able to create IAM groups with specific policies attached.

resource aws_iam_user this {
  for_each = toset(var.users)
  name     = each.value
}


