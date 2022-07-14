resource "aws_iam_group" "purple_iris_powerusers" {
  name = "purple-iris-powerusers"
}

resource "aws_iam_group_policy_attachment" "group_purple_iris_powerusers_poweruser" {
  group      = aws_iam_group.purple_iris_powerusers.name
  policy_arn = data.aws_iam_policy.poweruser.arn
}

resource "aws_iam_group_policy_attachment" "group_purple_iris_powerusers-force_mfa" {
  group      = aws_iam_group.purple_iris_powerusers.name
  policy_arn = aws_iam_policy.force_mfa.arn
}

resource "aws_iam_group_membership" "purple_iris_powerusers" {
  name  = "purple-iris-powerusers-membership"
  group = aws_iam_group.purple_iris_powerusers.name
  users = [
    aws_iam_user.nikolai_rahimi.name,
  ]
}

resource "aws_iam_policy" "purple_iris_poweruser" {
  name        = "purple-iris-poweruser-access"
  path        = "/"
  description = "Allow user to assume role in Purple Iris - Develop account"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "sts:AssumeRole"
      Resource = "arn:aws:iam::${local.purple_iris_develop_account.id}:role/poweruser"
    }]
  })
}

resource "aws_iam_group_policy_attachment" "purple_iris_poweruser" {
  group      = aws_iam_group.purple_iris_powerusers.name
  policy_arn = aws_iam_policy.purple_iris_poweruser.arn
}
