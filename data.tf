data "aws_caller_identity" "current" {}

data "aws_iam_policy" "poweruser" {
  name = "PowerUserAccess"
}

data "aws_iam_policy" "administrator" {
  name = "AdministratorAccess"
}

data "aws_iam_policy" "read_only" {
  name = "ReadOnlyAccess"
}

data "aws_organizations_organization" "tabularasadevelopment" {}

data "aws_organizations_organizational_units" "org_units" {
  parent_id = data.aws_organizations_organization.tabularasadevelopment.roots[0].id
}
