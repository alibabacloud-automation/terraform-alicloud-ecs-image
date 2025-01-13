
#####################
# image-create
#####################
variable "create" {
  description = "Whether to create image."
  type        = bool
  default     = false
}

variable "create_image_by_instance" {
  description = "Whether to create image by instance."
  type        = bool
  default     = true
}

variable "create_image_by_snapshot" {
  description = "Whether to create image by snapshot."
  type        = bool
  default     = true
}

variable "create_image_by_disk" {
  description = "Whether to create image by disk."
  type        = bool
  default     = true
}

variable "image_name" {
  description = "The name of image created by instance."
  type        = string
  default     = ""
}

variable "snapshot_image_name" {
  description = "The name of image created by snapshot."
  type        = string
  default     = ""
}

variable "disk_image_name" {
  description = "The name of image created by disk."
  type        = string
  default     = ""
}

variable "image_create_architecture" {
  description = "The architecture of the system disk. Default to 'x86_64'."
  type        = string
  default     = "x86_64"
}

variable "instance_id" {
  description = "The id of instance."
  type        = string
  default     = ""
}

variable "snapshot_id" {
  description = "The id of snapshot."
  type        = string
  default     = ""
}

variable "instance_image_description" {
  description = "The description of the image created by instance."
  type        = string
  default     = ""
}

variable "snapshot_image_description" {
  description = "The description of the image created by snapshot."
  type        = string
  default     = ""
}

variable "disk_image_description" {
  description = "The description of the image created by disk."
  type        = string
  default     = ""
}

variable "instance_image_create_platform" {
  description = "The operating system platform of the system disk created by instance. Default to 'Ubuntu'."
  type        = string
  default     = "Ubuntu"
}

variable "snapshot_image_create_platform" {
  description = "The operating system platform of the system disk created by snapshot. Default to 'Ubuntu'."
  type        = string
  default     = "Ubuntu"
}

variable "disk_image_create_platform" {
  description = "The operating system platform of the system disk created by disk. Default to 'Ubuntu'."
  type        = string
  default     = "Ubuntu"
}

variable "resource_group_id" {
  description = "The ID of the enterprise resource group to which a custom image belongs."
  type        = string
  default     = ""
}

variable "force" {
  description = "Indicates whether to force delete the custom image, Default is 'false'."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the image."
  type        = map(string)
  default     = {}
}

variable "disk_device_mapping" {
  description = "List of disk device mapping used to create image. Each item can contains keys:'size'(The size of a diskin the combined custom image. It's not empty),'device'(The name of a disk in the combined custom image. Value range: /dev/xvda to /dev/xvdz.),'snapshot_id'(The id of snapshot that is used to create a combined custom image.),'disk_type'(The type of a disk in the combined custom image.)."
  type        = list(map(string))
  default     = []
}

#####################
# image-export
#####################
variable "export" {
  description = "Whether to export the image. Default to 'false'."
  type        = bool
  default     = false
}

variable "export_image_ids" {
  description = "The id of image by export"
  type        = list(string)
  default     = []
}

variable "export_oss_bucket" {
  description = "Save the exported OSS bucket."
  type        = string
  default     = ""
}

variable "oss_prefix" {
  description = "The prefix of your OSS Object. Default to 'tf'."
  type        = string
  default     = "tf"
}

variable "create_timeouts" {
  description = "Used when exporting the image (until it reaches the initial Available status)."
  type        = string
  default     = "20m"
}

#####################
# image-import
#####################
variable "import" {
  description = "Whether to import the image. Default to 'false'."
  type        = bool
  default     = false
}

variable "import_image_name" {
  description = "The name of imported image. If not set, a default name with prefix 'tf-import-image-' will be returned."
  type        = string
  default     = ""
}

variable "image_import_architecture" {
  description = "The architecture of the system disk. Default to 'x86_64'."
  type        = string
  default     = "x86_64"
}

variable "description" {
  description = "The description of the image."
  type        = string
  default     = ""
}

variable "license_type" {
  description = "Activate the type of license used by the operating system after importing the image. Default to 'Auto'."
  type        = string
  default     = "Auto"
}

variable "image_import_platform" {
  description = "The operating system platform of the system disk. Default to 'Ubuntu'."
  type        = string
  default     = "Ubuntu"
}

variable "os_type" {
  description = "Operating system platform type. Default to 'linux'."
  type        = string
  default     = "linux"
}

variable "import_disk_device_mapping" {
  description = "List of disk device mapping. Each item can contains keys:'import_oss_bucket'(The bucket where imported image belongs.),'oss_object'(The name of image in oss bucket.)."
  type        = map(string)
  default     = {}
}

#####################
# image-share-permission-permisstion
#####################
variable "share" {
  description = "Whether to share the image. Default to 'false'."
  type        = bool
  default     = false
}

variable "share_image_ids" {
  description = "The id of image by share"
  type        = list(string)
  default     = []
}

variable "account_ids" {
  description = "Alibaba Cloud account id used to share images."
  type        = list(string)
  default     = []
}