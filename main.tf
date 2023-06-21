data "google_project" "current" {
  project_id = var.project_id
}
#-------------------#
# Activate services #
#-------------------#

data "terracurl_request" "firefly_login" {
  name           = "firefly_gcp_integration"
  url            = "${var.firefly_endpoint}/account/access_keys/login"
  method         = "POST"
  headers        = {
    Content-Type: "application/json",
  }
  request_body = jsonencode({ "accessKey"=var.firefly_access_key,  "secretKey"=var.firefly_secret_key })

}

output "token" {
  value = jsondecode(data.terracurl_request.firefly_login.response).access_token
}

output "response_code" {
  value = data.terracurl_request.firefly_login.response
}

resource "terracurl_request" "firefly_gcp_integration" {
  name           = "firefly gcp provider integration"
  url            = "${var.firefly_endpoint}/integrations/google"
  method         = "POST"
  request_body   = jsonencode(
    {
      "name"= var.name,
      "projectId"= var.project_id,
      "isPrimary" = true,
      "shouldAutoDiscoverProjects" = true,
      "serviceAccountKey"= tostring(base64decode(google_service_account_key.credentials.private_key))
    }
  )

 lifecycle {
      ignore_changes = [
        headers,
        destroy_headers
      ]
  }

  headers = {
    Content-Type = "application/json"
    Authorization: "Bearer ${jsondecode(data.terracurl_request.firefly_login.response).access_token}"
  }

  response_codes = [200]

  destroy_url    = "${var.firefly_endpoint}/integrations/google/integration/project"
  destroy_method = "DELETE"

  destroy_headers = {
    Content-Type = "application/json"
    Authorization: "Bearer ${jsondecode(data.terracurl_request.firefly_login.response).access_token}"
  }

  destroy_request_body =  jsonencode(
    {
      "name"= var.name,
      "projectId"= var.project_id
    }
  )
  destroy_response_codes = [204]
  depends_on = [google_project_iam_member.service_account_project_membership, google_project_iam_member.service_account_project_membership_storage_viewer]
}

