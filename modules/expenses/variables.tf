variable "public_path" {
  description = "The file path for the public directory"
  type        = string
  #default     = "${path.root}/public/index.html"
}

variable "user_uuid" {
  description = "The UUID of the user"
  type        = string
/*   validation {
    condition        = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message    = "The user_uuid value is not a valid UUID."
  } */
}
