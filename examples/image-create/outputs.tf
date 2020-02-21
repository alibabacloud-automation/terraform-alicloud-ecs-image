output "this_create_image_ids" {
  description = "The id of created image."
  value       = module.image_create.this_create_image_ids
}

output "this_create_image_tag" {
  description = "The create image tags."
  value       = module.image_create.this_create_image_tag
}

output "this_import_image_name" {
  description = "The name of image imported form oss_bucket."
  value       = module.image_create.this_import_image_name
}

output "this_image_export_oss_export" {
  description = "Save the exported OSS bucket."
  value       = module.image_create.this_image_export_oss_export
}

output "this_image_share_permission_image_ids" {
  description = "The id of shared image."
  value       = module.image_create.this_share_image_permission_image_ids
}

output "this_image_share_permission_account_ids" {
  description = "The id of account that sharing image."
  value       = module.image_create.this_share_image_permission_account_ids
}