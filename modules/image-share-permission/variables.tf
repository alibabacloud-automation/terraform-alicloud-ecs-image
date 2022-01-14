variable "region" {
  description = "(Deprecated from version 1.3.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 1.3.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "(Deprecated from version 1.3.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 1.3.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

#####################
# image-share-permission-permisstion
#####################
variable "share" {
  description = "Whether to share the image. Default to 'false'."
  type        = bool
  default     = false
}

variable "image_ids" {
  description = "List of source image ID."
  type        = list(string)
  default     = []
}

variable "account_ids" {
  description = "Alibaba Cloud account id used to share images."
  type        = list(string)
  default     = []
}