<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.access_bastion_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.access_ec2_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_subnet_ssm_cidr"></a> [private\_subnet\_ssm\_cidr](#input\_private\_subnet\_ssm\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_private_subnet_ssm_nat_cidr"></a> [private\_subnet\_ssm\_nat\_cidr](#input\_private\_subnet\_ssm\_nat\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_bastion_sg"></a> [access\_bastion\_sg](#output\_access\_bastion\_sg) | n/a |
| <a name="output_access_ec2_sg"></a> [access\_ec2\_sg](#output\_access\_ec2\_sg) | n/a |
| <a name="output_endpoint_sg"></a> [endpoint\_sg](#output\_endpoint\_sg) | n/a |
<!-- END_TF_DOCS -->