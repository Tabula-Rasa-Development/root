resource "aws_iam_user" "nikolai_rahimi" {
  name = "nikolai.rahimi"
}

resource "aws_iam_user_policy_attachment" "nikolai-administrator" {
  user       = aws_iam_user.nikolai_rahimi.name
  policy_arn = data.aws_iam_policy.administrator.arn
}
