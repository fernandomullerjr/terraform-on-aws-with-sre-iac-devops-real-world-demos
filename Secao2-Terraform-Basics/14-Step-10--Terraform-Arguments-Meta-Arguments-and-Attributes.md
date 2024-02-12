
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "14. Step-10: Terraform Arguments, Meta-Arguments and Attributes."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# 14. Step-10: Terraform Arguments, Meta-Arguments and Attributes


## Step-03: Understand about Arguments, Attributes and Meta-Arguments.
- Arguments can be `required` or `optional`
- Attribues format looks like `resource_type.resource_name.attribute_name`
- Meta-Arguments change a resource type's behavior (Example: count, for_each)
- [Additional Reference](https://learn.hashicorp.com/tutorials/terraform/resource?in=terraform/configuration-language) 
- [Resource: AWS Instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Resource: AWS Instance Argument Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#argument-reference)
- [Resource: AWS Instance Attribute Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attributes-reference)
- [Resource: Meta-Arguments](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)




<https://developer.hashicorp.com/terraform/tutorials/configuration-language/resource?in=terraform%2Fconfiguration-language>
Resources have arguments, attributes, and meta-arguments.

    Arguments configure a particular resource; because of this, many arguments are resource-specific. Arguments can be required or optional, as specified by the provider. If you do not supply a required argument, Terraform will give an error and not apply the configuration.
    Attributes are values exposed by an existing resource. References to resource attributes take the format resource_type.resource_name.attribute_name. Unlike arguments which specify an infrastructure object's configuration, a resource's attributes are often assigned to it by the underlying cloud provider or API.
    Meta-arguments change a resource's behavior, such as using a count meta-argument to create multiple resources. Meta-arguments are a function of Terraform itself and are not resource or provider-specific.