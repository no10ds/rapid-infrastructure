# Rapid Module

Use this module to spin up a rAPId instance within existing AWS infrastructure.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_cluster"></a> [app\_cluster](#module\_app\_cluster) | ../app-cluster | n/a |
| <a name="module_auth"></a> [auth](#module\_auth) | ../auth | n/a |
| <a name="module_data_workflow"></a> [data\_workflow](#module\_data\_workflow) | ../data-workflow | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app-replica-count-desired"></a> [app-replica-count-desired](#input\_app-replica-count-desired) | The desired number of replicas of the app | `number` | `1` | no |
| <a name="input_app-replica-count-max"></a> [app-replica-count-max](#input\_app-replica-count-max) | The maximum desired number of replicas of the app | `number` | `2` | no |
| <a name="input_application_version"></a> [application\_version](#input\_application\_version) | The version number for the application image (e.g.: v1.0.4, v1.0.x-latest, etc.) | `string` | `"v1.3.0"` | no |
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | AWS Account number to host the rAPId service | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The region of the AWS Account for the rAPId service | `string` | n/a | yes |
| <a name="input_certificate_validation_arn"></a> [certificate\_validation\_arn](#input\_certificate\_validation\_arn) | Arn of the certificate used by the domain | `string` | `""` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name for the rAPId instance | `string` | n/a | yes |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | Hosted Zone ID with the domain Name Servers, pass quotes to create a new one from scratch | `string` | `""` | no |
| <a name="input_ip_whitelist"></a> [ip\_whitelist](#input\_ip\_whitelist) | A list of IPs to whitelist for access to the service | `list(string)` | n/a | yes |
| <a name="input_private_subnet_ids_list"></a> [private\_subnet\_ids\_list](#input\_private\_subnet\_ids\_list) | A list of private subnets from each organisation network config | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids_list"></a> [public\_subnet\_ids\_list](#input\_public\_subnet\_ids\_list) | A list of public subnets from the VPC config | `list(string)` | n/a | yes |
| <a name="input_rapid_ecr_url"></a> [rapid\_ecr\_url](#input\_rapid\_ecr\_url) | ECR Url for task definition | `string` | `"public.ecr.aws/no10-rapid/api"` | no |
| <a name="input_resource-name-prefix"></a> [resource-name-prefix](#input\_resource-name-prefix) | organization prefix of for naming | `string` | n/a | yes |
| <a name="input_support_emails_for_cloudwatch_alerts"></a> [support\_emails\_for\_cloudwatch\_alerts](#input\_support\_emails\_for\_cloudwatch\_alerts) | List of emails that will receive alerts from CloudWatch | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A common map of tags for all VPC resources that are created (for e.g. billing purposes) | `map(string)` | <pre>{<br>  "Resource": "data-f1-rapid"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the multihost VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
