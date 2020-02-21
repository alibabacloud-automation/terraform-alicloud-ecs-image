provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ecs-image"
}

resource "random_uuid" "this" {}

#####################
# create image by instance_id
#####################
resource "alicloud_image" "with_instance" {
  count = var.instance_id != "" ? 1 : 0

  image_name        = var.image_name != "" ? var.image_name : substr("tf-instance-image-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  architecture      = var.image_create_architecture
  instance_id       = var.instance_id
  description       = "An image comes from instance var.instance_id and created by Terraform."
  platform          = var.instance_image_create_platform
  resource_group_id = var.resource_group_id
  force             = var.force
  tags = merge({
    Created = "Terraform"
    Source  = "Instance:${var.instance_id}"
  }, var.tags)
}

#####################
# create image by snapshot_id
#####################
resource "alicloud_image" "with_snapshot" {
  count = var.snapshot_id != "" ? 1 : 0

  image_name        = var.image_name != "" ? var.image_name : substr("tf-snapshot-image-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  architecture      = var.image_create_architecture
  snapshot_id       = var.snapshot_id
  description       = "An image comes from snapshot var.snapshot_id and created by Terraform."
  platform          = var.snapshot_image_create_platform
  resource_group_id = var.resource_group_id
  force             = var.force
  tags = merge({
    Created = "Terraform"
    Source  = "Snapshot:${var.snapshot_id}"
  }, var.tags)
}

#####################
# create image by disk
#####################
resource "alicloud_image" "with_disk" {
  count = length(var.disk_device_mapping) > 0 ? 1 : 0

  image_name        = var.image_name != "" ? var.image_name : substr("tf-disk-image-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  architecture      = var.image_create_architecture
  description       = "An image comes from disk device mapping and created by Terraform."
  platform          = var.disk_image_create_platform
  resource_group_id = var.resource_group_id
  force             = var.force
  dynamic "disk_device_mapping" {
    for_each = var.disk_device_mapping
    content {
      device      = lookup(disk_device_mapping.value, "device", null)
      size        = lookup(disk_device_mapping.value, "size")
      disk_type   = lookup(disk_device_mapping.value, "disk_type", null)
      snapshot_id = lookup(disk_device_mapping.value, "snapshot_id", null)
    }
  }
  tags = merge({
    Created = "Terraform"
    Source  = "Disk"
  }, var.tags)
}

#####################
# image-export
#####################
locals {
  share_image_id  = flatten([alicloud_image.with_instance.*.id, alicloud_image.with_snapshot.*.id, alicloud_image.with_disk.*.id, alicloud_image_import.this.*.id])
  export_image_id = flatten([alicloud_image.with_instance.*.id, alicloud_image.with_snapshot.*.id, alicloud_image.with_disk.*.id])
}

resource "alicloud_image_export" "this" {
  count      = var.export ? length(local.export_image_id) : 0
  image_id   = local.export_image_id[count.index]
  oss_bucket = var.export_oss_bucket
  oss_prefix = var.oss_prefix
  timeouts {
    create = "20m"
  }
}

#####################
# image-import
#####################
resource "alicloud_image_import" "this" {
  count = var.import ? 1 : 0

  architecture = var.image_import_architecture
  description  = var.description
  image_name   = var.import_image_name != "" ? var.import_image_name : substr("tf-import-image-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  license_type = var.license_type
  platform     = var.image_import_platform
  os_type      = var.os_type

  disk_device_mapping {
    oss_bucket = lookup(var.import_disk_device_mapping, "import_oss_bucket")
    oss_object = lookup(var.import_disk_device_mapping, "oss_object")
  }
}

#####################
# image-share-permission-permisstion
#####################
module "image_share_permission" {
  source      = "./modules/image-share-permission"
  share       = var.share
  image_ids   = local.share_image_id
  account_ids = var.account_ids
}
