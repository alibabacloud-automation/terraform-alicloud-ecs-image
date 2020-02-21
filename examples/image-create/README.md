# image-create example

Configuration in this directory create ecs image.


# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Outputs
| Name | Description |
|------|-------------|
| this_create_image_id | The id of created image |
| this_import_image_name | The name of image imported form oss_bucket |
| this_image_export_oss_export | Save the exported OSS bucket |
| this_image_share_permission_image_id | The id of shared image |
| this_image_share_permission_account_id | The id of account that sharing image |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
