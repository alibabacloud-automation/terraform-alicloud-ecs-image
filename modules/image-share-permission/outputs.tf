output "this_share_image_permission_image_ids" {
  description = "The id of shared image."
  value       = alicloud_image_share_permission.this.*.image_id
}

output "this_share_image_permission_account_ids" {
  description = "The id of account that sharing image."
  value       = alicloud_image_share_permission.this.*.account_id
}