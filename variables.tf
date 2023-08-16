variable "firefly_access_key" {
  type        = string
  description = "Your authentication access_key"
}

variable "firefly_secret_key" {
  type        = string
  description = "Your authentication secret_key"
}


variable "project_id" {
  type        = string
  description = "The ID of the project to connect."
}

variable "name" {
  type        = string
  description = "Name of the integration in firefly"
}

variable "firefly_endpoint" {
  type        = string
  description = "The Firefly endpoint to register account management"
  default     = "https://prodapi.firefly.ai/api"
}

variable "resource_prefix" {
  type = string
  description = "Optional prefix to module resource names"
  default = ""
}

variable "enable_event_driven" {
  type = bool
  description = "Whether to create the integration as event driven or not"
  default = true
}
