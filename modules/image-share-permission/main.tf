provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ecs-image/image-share-permission"
}

#####################
# image-share-permission-permisstion
#####################
locals {
  share_image = flatten(
    [
      for _, image in var.image_ids : [
        for _, account in var.account_ids : {
          image_id   = image
          account_id = account
        }
      ]
    ]
  )
}
resource "alicloud_image_share_permission" "this" {
  count      = var.share ? length(local.share_image) : 0
  image_id   = lookup(local.share_image[count.index], "image_id", null)
  account_id = lookup(local.share_image[count.index], "account_id", null)
}