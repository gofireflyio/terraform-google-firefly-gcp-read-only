terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.6.0"
    }

    terracurl = {
      version = "0.1.0"
      source= "devops-rob/terracurl"
    }
  }
}
