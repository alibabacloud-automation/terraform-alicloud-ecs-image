#Create image
image_name                 = "update-tf-testacc-image"
snapshot_image_name        = "update-tf-testacc-snapshot-image"
disk_image_name            = "update-tf-testacc-disk-image"
instance_image_description = "update-tf-testacc-instance-image-description"
snapshot_image_description = "update-tf-testacc-snapshot-image-description"
disk_image_description     = "update-tf-testacc-disk-image-description"
force                      = true
tags = {
  Name = "updateIMAGE"
}

#Export image
create_timeouts = "30m"

#Import image
import_image_name = "update-tf-testacc-import-image"
description       = "update-tf-testacc-description"