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
# image-copy
#####################
variable "image_name" {
  description = "The name of image."
  type        = string
  default     = ""
}

variable "source_image_id" {
  description = "The source image ID."
  type        = string
}

variable "source_region_id" {
  description = "The ID of the region to which the source custom image belongs."
  type        = string
}

variable "description" {
  description = "The description of the image."
  type        = string
  default     = "The image copied from terraform."
}

variable "encrypted" {
  description = "Indicates whether to encrypt the image. Default to 'false'"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "Key ID used to encrypt the image."
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

variable "copy" {
  description = "Whether to copy the image. Default to 'false'."
  type        = bool
  default     = false
}