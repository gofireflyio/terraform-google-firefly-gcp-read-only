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
  description = "The GCP ID of the project to connect."
}

variable "name" {
  type        = string
  description = "Name of the GCP integration in firefly"
}

variable "firefly_endpoint" {
  type        = string
  description = "The Firefly endpoint to register account management"
  default     = "https://prodapi.gofirefly.io/api"
}
