<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.42.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat-eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw-ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat-ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.tf-rt-public-gw-ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.rt_porteiro](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.rt_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.rt_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.tf-private-rt-ssm-assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.tf-private-rta-assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private-subnet-ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private-subnet-ssm-nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public-subnet-ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.ec2messages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.endpoint_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssmmessages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b"<br>]</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_private_subnet_ssm_cidr"></a> [private\_subnet\_ssm\_cidr](#input\_private\_subnet\_ssm\_cidr) | CIDR block for Private Subnet SSM | `string` | `"172.35.0.0/20"` | no |
| <a name="input_private_subnet_ssm_nat_cidr"></a> [private\_subnet\_ssm\_nat\_cidr](#input\_private\_subnet\_ssm\_nat\_cidr) | CIDR block for Private Subnet SSM NAT | `string` | `"172.35.16.0/20"` | no |
| <a name="input_public_subnet_ssm_cidr"></a> [public\_subnet\_ssm\_cidr](#input\_public\_subnet\_ssm\_cidr) | CIDR block for Private Subnet SSM | `string` | `"172.35.32.0/20"` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | n/a | `list(any)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block of the vpc-ssm | `string` | `"172.35.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private-subnet-ssm-nat"></a> [private-subnet-ssm-nat](#output\_private-subnet-ssm-nat) | n/a |
| <a name="output_private_subnet_ssm_cidr"></a> [private\_subnet\_ssm\_cidr](#output\_private\_subnet\_ssm\_cidr) | n/a |
| <a name="output_private_subnet_ssm_id"></a> [private\_subnet\_ssm\_id](#output\_private\_subnet\_ssm\_id) | n/a |
| <a name="output_private_subnet_ssm_nat_id"></a> [private\_subnet\_ssm\_nat\_id](#output\_private\_subnet\_ssm\_nat\_id) | n/a |
| <a name="output_vpc_ssm_id"></a> [vpc\_ssm\_id](#output\_vpc\_ssm\_id) | n/a |
<!-- END_TF_DOCS -->