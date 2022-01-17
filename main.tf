data "google_project" "current" {
  project_id = var.project_id
}
#-------------------#
# Activate services #
#-------------------#

data "httpclient_request" "req" {
  url = '${var.firefly_endpoint}/account/access_keys/login'
  request_headers = {
    Content-Type: "application/json",
  }
  request_body = jsonencode({ "accessKey" : var.firefly_access_key,  "secretKey" : var.firefly_secret_key })
}

output "token" {
  value = jsondecode(data.httpclient_request.req.response_body).access_token
}

output "response_code" {
  value = data.httpclient_request.req.response_code
}

resource "null_resource" "notify_firefly" {
  triggers = {
    version = local.version
  }

  provisioner "local-exec" {
    command = <<CURL
curl --request POST '${var.firefly_endpoint}/api/integrations/gcp/' \
  --header 'Content-Type: application/json' \
  --data-raw '${jsonencode({ "name" : var.name,  "projectId" : var.project_id, "serviceAccountKey": jsondecode(base64decode(google_service_account_key.credentials)) )}'
CURL
  }

  depends_on = [google_project_iam_member.service_account_project_membership]
}