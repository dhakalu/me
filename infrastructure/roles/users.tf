resource "aws_iam_user" "terraform" {
  name          = "terraform"
  force_destroy = true
  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "terraform" {
  user = aws_iam_user.terraform.name
}

resource "aws_iam_user_policy_attachment" "terraform" {
  for_each = tomap({
    create = aws_iam_policy.terraform_create.arn
    read   = aws_iam_policy.terraform_read.arn
    update = aws_iam_policy.terraform_update.arn
    delete = aws_iam_policy.terraform_delete.arn
  })
  user       = aws_iam_user.terraform.name
  policy_arn = each.value
}
