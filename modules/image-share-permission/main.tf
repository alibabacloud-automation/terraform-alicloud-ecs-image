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
  count = var.share ? length(local.share_image) : 0

  image_id   = lookup(local.share_image[count.index], "image_id", null)
  account_id = lookup(local.share_image[count.index], "account_id", null)
}