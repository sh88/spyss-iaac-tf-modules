# Create IAM groups module to be able to create IAM groups with specific policies attached.

resource aws_iam_group this {
  for_each = toset(var.group_names)
  name = each.value
  path = var.group_path
}


