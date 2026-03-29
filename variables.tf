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

variable "enable_iac_auto_discover" {
  type = bool
  description = "Whether to create the integration with IaC auto discover (searches for state files in GCS buckets)"
  default = true
}

variable "is_prod" {
  type        = bool
  default     = false
  description = "Is Production?"
}

variable "exclude_projects_discovery_regex" {
  type        = list(string)
  default     = []
  description = "Regex to exclude projects from discovery. If empty, all found projects will be discovered and added as integration to Firefly"
}

variable "enable_folder_viewer" {
  type        = bool
  default     = true
  description = "Should Firefly discover the projects' folder names?"
}

variable "org_id" {
  type = string
  description = "Mandatory only for folders viewer."
  default = ""
}
