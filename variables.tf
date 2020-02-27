variable "region" {
  description = "The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

#####################
# image-create
#####################
variable "create" {
  description = "Whether to create image."
  type        = bool
  default     = true
}

variable "image_name" {
  description = "The name of image."
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
  default     = "Image created by terraform"
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
# image-export
#####################
variable "export" {
  description = "Whether to export the image. Default to 'false'."
  type        = bool
  default     = false
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

#####################
# image-share-permission-permisstion
#####################
variable "account_ids" {
  description = "Alibaba Cloud account id used to share images."
  type        = list(string)
  default     = []
}

variable "share" {
  description = "Whether to share the image. Default to 'false'."
  type        = bool
  default     = false
}