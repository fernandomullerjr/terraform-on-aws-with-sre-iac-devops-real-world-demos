
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "47. Step-06: Provider and Modules Version Constraints."
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 47. Step-06: Provider and Modules Version Constraints

## Step-04: Version Constraints in Terraform with Modules
- [Terraform Version Constraints](https://www.terraform.io/docs/language/expressions/version-constraints.html)
- For modules locking to the exact version is recommended to ensure there will not be any major breakages in production
- When depending on third-party modules, require specific versions to ensure that updates only happen when convenient to you
- For modules maintained within your organization, specifying version ranges may be appropriate if semantic versioning is used consistently or if there is a well-defined release process that avoids unwanted updates.
- [Review and understand this carefully](https://www.terraform.io/docs/language/expressions/version-constraints.html#terraform-core-and-provider-versions)
