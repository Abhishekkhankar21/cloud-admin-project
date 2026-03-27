resource "aws_organizations_organizational_unit" "dev_ou" {
  name      = "Dev"
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "prod_ou" {
  name      = "Prod"
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "test_ou" {
  name      = "test"
  parent_id = data.aws_organizations_organization.org.roots[0].id
}