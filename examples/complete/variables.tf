# alicloud_ecs_disk
variable "system_disk_size" {
  description = "The system disk size used to launch ecs instance."
  type        = number
  default     = 30
}

# image-create
variable "image_name" {
  description = "The name of image."
  type        = string
  default     = "tf-testacc-image"
}

variable "snapshot_image_name" {
  description = "The name of image created by snapshot."
  type        = string
  default     = "tf-testacc-snapshot-image"
}

variable "disk_image_name" {
  description = "The name of image created by disk."
  type        = string
  default     = "tf-testacc-disk-image"
}

variable "instance_image_description" {
  description = "The description of the image created by instance."
  type        = string
  default     = "tf-testacc-instance-image-description"
}

variable "snapshot_image_description" {
  description = "The description of the image created by snapshot."
  type        = string
  default     = "tf-testacc-snapshot-image-description"
}

variable "disk_image_description" {
  description = "The description of the image created by disk."
  type        = string
  default     = "tf-testacc-disk-image-description"
}

variable "force" {
  description = "Indicates whether to force delete the custom image, Default is 'false'."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the image."
  type        = map(string)
  default = {
    Name = "IMAGE"
  }
}

# image-export
variable "create_timeouts" {
  description = "Used when exporting the image (until it reaches the initial Available status)."
  type        = string
  default     = "20m"
}

# image-import
variable "import_image_name" {
  description = "The name of imported image. If not set, a default name with prefix 'tf-import-image-' will be returned."
  type        = string
  default     = "tf-testacc-import-image"
}

variable "description" {
  description = "The description of the image."
  type        = string
  default     = "tf-testacc-description"
}

variable "another_uid" {
  description = "The uid of another user."
  type        = string
  default     = "123456789"
}