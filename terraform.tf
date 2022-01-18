terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.6.0"
    }

    httpclient = {
          version = "0.0.3"
          source  = "dmachard/http-client"
        }
  }
}