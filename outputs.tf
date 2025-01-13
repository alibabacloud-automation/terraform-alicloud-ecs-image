output "this_create_image_ids" {
  description = "The ids of image."
  value       = concat(alicloud_image.with_instance[*].id, alicloud_image.with_snapshot[*].id, alicloud_image.with_disk[*].id)
}

output "this_create_image_tag" {
  description = "The create image tags."
  value       = concat(alicloud_image.with_instance[*].tags, alicloud_image.with_snapshot[*].tags, alicloud_image.with_disk[*].tags)
}

output "this_import_image_name" {
  description = "The name of image imported form oss_bucket."
  value       = concat(alicloud_image_import.this[*].image_name, [""])[0]
}

output "this_image_export_oss_export" {
  description = "Save the exported OSS bucket."
  value       = concat(alicloud_image_export.this[*].oss_bucket, [""])[0]
}

output "this_share_image_permission_image_ids" {
  description = "The id of shared image."
  value       = module.image_share_permission.this_share_image_permission_image_ids
}

output "this_share_image_permission_account_ids" {
  description = "The id of account that sharing image."
  value       = module.image_share_permission.this_share_image_permission_account_ids
}