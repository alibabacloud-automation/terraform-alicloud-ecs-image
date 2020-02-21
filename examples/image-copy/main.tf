module "image_copy" {
  source = "../../modules/image-copy"

  copy             = true
  source_image_id  = "m-bp15cboxe6xv942y****"
  source_region_id = "cn-hangzhou"
}