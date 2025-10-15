provider "alicloud" {
  region = "cn-zhangjiakou"
}

data "alicloud_zones" "default" {
}

data "alicloud_resource_manager_resource_groups" "default" {
}

data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones[0].id
  cpu_core_count       = 2
  memory_size          = 8
  instance_type_family = "ecs.g9i"
}

data "alicloud_images" "default" {
  owners        = "system"
  most_recent   = true
  instance_type = data.alicloud_instance_types.default.instance_types[0].id
}

resource "alicloud_ecs_disk" "default" {
  zone_id  = data.alicloud_zones.default.zones[0].id
  size     = var.system_disk_size
  category = "cloud_essd"
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
  source  = "alibaba/security-group/alicloud"
  version = "~>2.4.0"

  vpc_id = module.vpc.this_vpc_id
}

module "ecs_instance" {
  source  = "alibaba/ecs-instance/alicloud"
  version = "~>2.12.0"

  number_of_instances = 2

  instance_type        = data.alicloud_instance_types.default.instance_types[0].id
  image_id             = data.alicloud_images.default.images[0].image_id
  vswitch_ids          = [module.vpc.this_vswitch_ids[0]]
  security_group_ids   = [module.security_group.this_security_group_id]
  system_disk_category = "cloud_essd"
}

resource "alicloud_ecs_disk_attachment" "default" {
  disk_id     = alicloud_ecs_disk.default.id
  instance_id = module.ecs_instance.this_instance_id[0]
}

resource "random_uuid" "this" {}

module "oss_bucket" {
  source      = "terraform-alicloud-modules/oss-bucket/alicloud"
  version     = "~>1.5.0"
  bucket_name = "tf-oss-bucket-${random_uuid.this.result}"
  acl         = "public-read"
}

module "vpc" {
  source  = "alibaba/vpc/alicloud"
  version = "~>1.11.0"

  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones[0].id]
}

#Create image
module "image_create" {
  source = "../.."

  #create image by instance_id
  create_image_by_instance = true

  image_name                     = "${var.image_name}-${random_uuid.this.result}"
  image_create_architecture      = "x86_64"
  instance_id                    = module.ecs_instance.this_instance_id[0]
  instance_image_description     = var.instance_image_description
  instance_image_create_platform = data.alicloud_images.default.images[0].platform
  resource_group_id              = data.alicloud_resource_manager_resource_groups.default.groups[0].id
  force                          = var.force
  tags                           = var.tags

  #create image by snapshot_id
  create_image_by_snapshot = true

  snapshot_image_name            = "${var.snapshot_image_name}-${random_uuid.this.result}"
  snapshot_id                    = alicloud_ecs_snapshot.default.id
  snapshot_image_description     = var.snapshot_image_description
  snapshot_image_create_platform = data.alicloud_images.default.images[0].platform

  #create image by disk
  create_image_by_disk = true

  disk_image_name            = "${var.disk_image_name}-${random_uuid.this.result}"
  disk_image_description     = var.disk_image_description
  disk_image_create_platform = data.alicloud_images.default.images[0].platform
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

  depends_on = [alicloud_ecs_snapshot.default]

}

resource "alicloud_image" "image_export" {
  instance_id = module.ecs_instance.this_instance_id[1]
  image_name  = "terraform-example-${random_uuid.this.result}"
  description = "terraform-example"
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

  export_image_ids  = [alicloud_image.image_export.id]
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

data "alicloud_regions" "default" {
  current = true
}

provider "alicloud" {
  region = "cn-hangzhou"
  alias  = "hz"
}

module "image_copy" {
  source = "../../modules/image-copy"
  providers = {
    alicloud = alicloud.hz
  }

  copy             = true
  source_image_id  = alicloud_image.image_export.id
  source_region_id = data.alicloud_regions.default.regions[0].id
}




module "image_share_permission" {
  source = "../../modules/image-share-permission"

  share       = true
  account_ids = [var.another_uid]
  image_ids   = [alicloud_image.image_export.id]
}
