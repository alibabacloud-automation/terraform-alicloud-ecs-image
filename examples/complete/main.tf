data "alicloud_zones" "default" {
}

data "alicloud_resource_manager_resource_groups" "default" {
}

data "alicloud_images" "default" {
  name_regex = "ubuntu"
}

data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_ecs_disk" "default" {
  zone_id = data.alicloud_zones.default.zones.0.id
  size    = var.system_disk_size
}

resource "alicloud_ecs_snapshot" "default" {
  disk_id  = alicloud_ecs_disk_attachment.default.disk_id
  category = "standard"
}

resource "alicloud_oss_bucket_object" "default" {
  bucket  = module.oss_bucket.this_oss_bucket_id
  key     = "tf-oss-bucket-object-key"
  content = var.description
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.this_vpc_id
}

module "ecs_instance" {
  source = "alibaba/ecs-instance/alicloud"

  number_of_instances = 1

  instance_type      = data.alicloud_instance_types.default.instance_types.0.id
  image_id           = data.alicloud_images.default.images.0.id
  vswitch_ids        = [module.vpc.this_vswitch_ids[0]]
  security_group_ids = [module.security_group.this_security_group_id]
}

resource "alicloud_ecs_disk_attachment" "default" {
  disk_id     = alicloud_ecs_disk.default.id
  instance_id = module.ecs_instance.this_instance_id[0]
}

module "oss_bucket" {
  source      = "terraform-alicloud-modules/oss-bucket/alicloud"
  bucket_name = "tf-oss-bucket-2022"
  acl         = "public-read"
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones.0.id]
}

#Create image
module "image_create" {
  source = "../.."

  #create image by instance_id
  create_image_by_instance = true

  image_name                     = var.image_name
  image_create_architecture      = "x86_64"
  instance_id                    = module.ecs_instance.this_instance_id[0]
  instance_image_description     = var.instance_image_description
  instance_image_create_platform = "Ubuntu"
  resource_group_id              = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  force                          = var.force
  tags                           = var.tags

  #create image by snapshot_id
  create_image_by_snapshot = true

  snapshot_image_name            = var.snapshot_image_name
  snapshot_id                    = alicloud_ecs_snapshot.default.id
  snapshot_image_description     = var.snapshot_image_description
  snapshot_image_create_platform = "Ubuntu"

  #create image by disk
  create_image_by_disk = true

  disk_image_name            = var.disk_image_name
  disk_image_description     = var.disk_image_description
  disk_image_create_platform = "Ubuntu"
  disk_device_mapping = [
    {
      device      = "/dev/xvda"
      size        = 30
      disk_type   = "system"
      snapshot_id = alicloud_ecs_snapshot.default.id
    }
  ]

  #Export image
  export = false

  #Import image
  import = false

  #Share image
  share = false

}

#Export image
module "image_export" {
  source = "../.."

  #create image by instance_id
  create_image_by_instance = false

  #create image by snapshot_id
  create_image_by_snapshot = false

  #create image by disk
  create_image_by_disk = false

  #Export image
  export = true

  export_image_ids  = [module.image_create.this_create_image_ids[0]]
  export_oss_bucket = module.oss_bucket.this_oss_bucket_id
  oss_prefix        = "tf"
  create_timeouts   = var.create_timeouts

  #Import image
  import = false

  #Share image
  share = false

}

#Import image
module "image_import" {
  source = "../.."

  #create image by instance_id
  create_image_by_instance = false

  #create image by snapshot_id
  create_image_by_snapshot = false

  #create image by disk
  create_image_by_disk = false

  #Export image
  export = false

  #Import image
  import = true

  image_import_architecture = "x86_64"
  import_image_name         = var.import_image_name
  description               = var.description
  license_type              = "Auto"
  image_import_platform     = "Ubuntu"
  os_type                   = "linux"

  import_disk_device_mapping = {
    import_oss_bucket = module.image_export.this_image_export_oss_export
    oss_object        = alicloud_oss_bucket_object.default.id
  }

  #Share image
  share = false

}