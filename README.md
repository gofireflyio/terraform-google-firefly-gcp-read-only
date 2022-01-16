# Firefly GCP ReadOnly Integration

## Module contents

This module enables the APIs that allow us to have visibility into your Google Project
and creates a service account for us to scan that project for misconfigurations.
The service account requires the "Viewer" role in order to function properly.

## Configuration

### Prerequisites

This module requires the cURL library to be installed on your machine.
To check if you have cURL installed, type the following command in your terminal:

```shell script
curl --help
```

### Installation

```hcl-terraform
module "firefly-read-only" {
  source              = "infralight/terraform-google-firefly-gcp-read-only"
  firefly_access_key  = "YOUR_ACCESS_KEY"
  fierfly_secret_key  = "YOUR_SECRET_KEY"
}
```

# ![Firefly Logo](firefly.gif)
