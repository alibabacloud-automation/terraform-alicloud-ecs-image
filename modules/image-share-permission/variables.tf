

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