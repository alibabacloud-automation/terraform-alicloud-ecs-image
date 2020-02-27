variable "region" {
  region = "cn-shanghai"
}

variable "profile" {
  profile = "default"
}

provider "alicloud" {
  region  = var.region
  profile = var.profile
}

######################
# Create image
######################
module "image_create" {
  source      = "../.."
  region      = var.region
  profile     = var.profile
  create      = true
  instance_id = "i-uf6etbb1qr3hri95****"
  snapshot_id = "s-uf606ogbpv2patop****"
  disk_device_mapping = [
    {
      device      = "/dev/xvda"
      size        = 50
      disk_type   = "system"
      snapshot_id = "s-uf66875xwpzdqh8i****"
    },
    {
      size      = 5
      disk_type = "data"
    }
  ]
  share             = true
  account_ids       = ["591014693150****"]
  export            = true
  export_oss_bucket = "image-test"
}

######################
# Import image
######################
module "image_import" {
  source            = "../.."
  region            = var.region
  profile           = var.profile
  import            = true
  import_image_name = "tf-001"
  import_disk_device_mapping = {
    import_oss_bucket = "image-test"
    oss_object        = "tf_m-uf6gkgbv29y104788x97xxxxxx"
  }
}
