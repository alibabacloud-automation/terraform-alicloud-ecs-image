output "this_create_image_ids" {
  description = "The id of image created by instance."
  value       = module.image_create.this_create_image_ids
}

output "this_create_image_tag" {
  description = "The create image tags."
  value       = module.image_create.this_create_image_tag
}

output "this_import_image_name" {
  description = "The name of image imported form oss_bucket."
  value       = module.image_import.this_import_image_name
}

output "this_image_export_oss_export" {
  description = "Save the exported OSS bucket."
  value       = module.image_export.this_image_export_oss_export
}