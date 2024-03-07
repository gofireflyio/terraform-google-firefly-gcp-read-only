terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.6.0"
    }
    
    http = {
      source = "hashicorp/http"
      version = "3.4.2"
    }
  }
}
