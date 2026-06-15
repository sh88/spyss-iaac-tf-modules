# Create IAM groups module to be able to create IAM groups with specific policies attached.

resource aws_iam_group this {
  name = var.group_name
  path = var.group_path
}


