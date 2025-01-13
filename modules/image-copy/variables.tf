

#####################
# image-copy
#####################
variable "copy" {
  description = "Whether to copy the image. Default to 'false'."
  type        = bool
  default     = false
}

variable "image_name" {
  description = "The name of image."
  type        = string
  default     = ""
}

variable "source_image_id" {
  description = "The source image ID."
  type        = string
  default     = ""
}

variable "source_region_id" {
  description = "The ID of the region to which the source custom image belongs."
  type        = string
  default     = ""
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