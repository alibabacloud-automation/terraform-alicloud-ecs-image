output "this_image_share_permission_image_ids" {
  description = "The id of shared image."
  value       = module.image_share_permission.this_share_image_permission_image_ids
}

output "this_image_share_permission_account_ids" {
  description = "The id of account that sharing image."
  value       = module.image_share_permission.this_share_image_permission_account_ids
}