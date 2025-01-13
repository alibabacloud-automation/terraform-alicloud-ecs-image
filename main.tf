resource "random_uuid" "this" {}

#####################
# create image by instance_id
#####################
resource "alicloud_image" "with_instance" {
  count = var.create ? 1 : var.create_image_by_instance ? 1 : 0

  image_name        = var.image_name != "" ? var.image_name : substr("tf-instance-image-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  architecture      = var.image_create_architecture
  instance_id       = var.instance_id
  description       = var.instance_image_description
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
  count = var.create ? 1 : var.create_image_by_snapshot ? 1 : 0

  image_name        = var.snapshot_image_name != "" ? var.snapshot_image_name : substr("tf-snapshot-image-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  architecture      = var.image_create_architecture
  snapshot_id       = var.snapshot_id
  description       = var.snapshot_image_description
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
  count = var.create ? 1 : var.create_image_by_disk ? 1 : 0

  image_name        = var.disk_image_name != "" ? var.disk_image_name : substr("tf-disk-image-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  architecture      = var.image_create_architecture
  description       = var.disk_image_description
  platform          = var.disk_image_create_platform
  resource_group_id = var.resource_group_id
  force             = var.force
  dynamic "disk_device_mapping" {
    for_each = var.disk_device_mapping
    content {
      device      = lookup(disk_device_mapping.value, "device", null)
      size        = disk_device_mapping.value["size"]
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
  export_image_ids = length(var.export_image_ids) > 0 ? var.export_image_ids : flatten([alicloud_image.with_instance[*].id, alicloud_image.with_snapshot[*].id, alicloud_image.with_disk[*].id])
  share_image_ids  = length(var.share_image_ids) > 0 ? var.share_image_ids : flatten([alicloud_image.with_instance[*].id, alicloud_image.with_snapshot[*].id, alicloud_image.with_disk[*].id, alicloud_image_import.this[*].id])
}

resource "alicloud_image_export" "this" {
  count      = var.export ? length(local.export_image_ids) : 0
  image_id   = local.export_image_ids[count.index]
  oss_bucket = var.export_oss_bucket
  oss_prefix = var.oss_prefix
  timeouts {
    create = var.create_timeouts
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
    oss_bucket = var.import_disk_device_mapping["import_oss_bucket"]
    oss_object = var.import_disk_device_mapping["oss_object"]
  }

}

#####################
# image-share-permission-permisstion
#####################
module "image_share_permission" {
  source = "./modules/image-share-permission"

  share = var.share

  image_ids   = local.share_image_ids
  account_ids = var.account_ids

}