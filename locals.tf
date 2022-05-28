locals {
  purple_iris_develop_account = data.aws_organizations_organization.tabularasadevelopment.accounts[
    index(data.aws_organizations_organization.tabularasadevelopment.accounts[*].name, "Purple Iris - Develop")
  ]
}
