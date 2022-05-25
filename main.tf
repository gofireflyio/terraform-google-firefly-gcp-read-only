data "google_project" "current" {
  project_id = var.project_id
}
#-------------------#
# Activate services #
#-------------------#

data "httpclient_request" "req" {
  url = "${var.firefly_endpoint}/account/access_keys/login"
  request_headers = {
    Content-Type: "application/json",
  }
  request_method = "POST"
  request_body = jsonencode({ "accessKey"=var.firefly_access_key,  "secretKey"=var.firefly_secret_key })
}

output "token" {
  value = jsondecode(data.httpclient_request.req.response_body).access_token
}

output "response_code" {
  value = data.httpclient_request.req.response_code
}

resource "null_resource" "firefly_create_integration" {
  triggers = {
    version = local.version
  }

  provisioner "local-exec" {
    command = <<CURL
curl --request POST "${var.firefly_endpoint}/integrations/gcp/" \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${jsondecode(data.httpclient_request.req.response_body).access_token}" \
  --data ${jsonencode(jsonencode({"name"= var.name,"fetchable": true ,"projectId"= var.project_id, "serviceAccountKey"= tostring(base64decode(google_service_account_key.credentials.private_key)) })) }
CURL
  }

  depends_on = [google_project_iam_member.service_account_project_membership, google_project_iam_member.service_account_project_membership_storage_viewer]
}