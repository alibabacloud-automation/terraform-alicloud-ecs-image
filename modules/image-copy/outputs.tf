output "this_copy_image_id" {
  description = "The id of copied image."
  value       = concat(alicloud_image_copy.this.*.id, [""])[0]
}

output "this_copy_image_name" {
  description = "The name of copied image."
  value       = concat(alicloud_image_copy.this.*.image_name, [""])[0]
}