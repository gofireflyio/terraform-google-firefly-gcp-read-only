# Firefly GCP ReadOnly Integration
# ![Firefly Logo](firefly.gif)

## Module contents

This module enables the APIs that allow us to have visibility into your Google Project
and creates a service account for us to scan that project for misconfigurations.
The service account requires the "Viewer" role in order to function properly.

## Configuration

### Prerequisites

This module requires the cURL library to be installed on your machine.
To check if you have cURL installed, type the following command in your terminal:

```shell script
curl --version && gcloud version && terraform init
```

### Installation

```hcl-terraform
provider “google” {
  project = “<GCP_PROJECT_NAME>”
}
module “firefly” {
  source                = “git@github.com:gofireflyio/terraform-google-firefly-gcp-read-only.git”
  firefly_access_key    = “<SECRET>”
  firefly_secret_key    = “<SECRET>”
  name  		= “<INTEGRATION_NAME>”
  project_id	 	= “<GCP_PROJECT_NAME>”
  exclude_projects_discovery_regex = ["<EXCLUSION_REGEX>", "<EXCLUSION_REGEX>"] // optional
}
```
