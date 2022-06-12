resource "aws_iam_group" "purple_iris_developers" {
  name = "purple-iris-developers"
}

resource "aws_iam_group_policy_attachment" "group_purple_iris_developers_readonly" {
  group      = aws_iam_group.purple_iris_developers.name
  policy_arn = data.aws_iam_policy.read_only.arn
}

resource "aws_iam_group_policy_attachment" "group_purple_iris_developers-force_mfa" {
  group      = aws_iam_group.purple_iris_developers.name
  policy_arn = aws_iam_policy.force_mfa.arn
}

resource "aws_iam_group_membership" "purple_iris_developers" {
  name  = "purple-iris-developers-membership"
  group = aws_iam_group.purple_iris_developers.name
  users = [
    aws_iam_user.nikolai_rahimi.name,
    aws_iam_user.majid.alborji.name,
  ]
}

resource "aws_iam_policy" "purple_iris_develop" {
  name        = "purple-iris-develop-access"
  path        = "/"
  description = "Allow user to assume role in Purple Iris - Develop account"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "sts:AssumeRole"
      Resource = "arn:aws:iam::${local.purple_iris_develop_account.id}:role/read_only"
    }]
  })
}

resource "aws_iam_group_policy_attachment" "purple_iris_develop" {
  group      = aws_iam_group.purple_iris_developers.name
  policy_arn = aws_iam_policy.purple_iris_develop.arn
}
