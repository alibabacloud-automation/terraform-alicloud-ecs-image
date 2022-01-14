resource "random_uuid" "this" {}

#####################
# image-copy
#####################
resource "alicloud_image_copy" "this" {
  count = var.copy ? 1 : 0

  image_name       = var.image_name != "" ? var.image_name : substr("tf-copied-image-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  source_image_id  = var.source_image_id
  source_region_id = var.source_region_id
  description      = var.description
  encrypted        = var.encrypted
  kms_key_id       = var.kms_key_id
  force            = var.force
  tags = merge({
    Create = "Terraform"
    Source = "source_image_id:${var.source_image_id}"
    }, var.tags
  )

}