data "google_project" "current" {
  project_id = var.project_id
}
#-------------------#
# Activate services #
#-------------------#

data "http" "firefly_login" {
  url = "${var.firefly_endpoint}/account/access_keys/login"
  method = "POST"
  request_headers = {
    Content-Type = "application/json",
  }
  request_body = jsonencode({ "accessKey"=var.firefly_access_key, "secretKey"=var.firefly_secret_key })
}

locals {
  response_obj = try(jsondecode(data.http.firefly_login.response_body), {})
  token = lookup(local.response_obj, "access_token", "error")
}
output "token" {
  value = local.token
}

output "response_code" {
  value = data.http.firefly_login.status_code
}

  data "http" "firefly_gcp_integration" {
    url = "${var.firefly_endpoint}/integrations/google"
    method = "POST"
    request_body = jsonencode(
      {
        "name"= var.name,
        "projectId"= var.project_id,
        "isPrimary" = true,
        "shouldAutoDiscoverProjects" = true,
        "serviceAccountKey"= tostring(base64decode(google_service_account_key.credentials.private_key)),
        "isProd"= var.is_prod,
        "isEventDrivenDisabled"= !var.enable_event_driven,
        "isIacAutoDiscoverDisabled"= !var.enable_iac_auto_discover,
        "regexExcludeProjectsDiscovery"= var.exclude_projects_discovery_regex
      }
    )
    request_headers = {
      Content-Type = "application/json"
      Authorization: "Bearer ${local.token}"
    }
    depends_on = [google_project_iam_member.service_account_project_membership, google_project_iam_member.service_account_project_membership_storage_viewer, google_project_iam_member.service_account_project_event_driven_sink_creation]
  }

