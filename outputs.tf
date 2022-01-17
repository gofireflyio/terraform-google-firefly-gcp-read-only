
output "service_account" {
  value = google_service_account.firefly
}

output "project_membership" {
  value = google_project_iam_member.service_account_project_membership
}

output "project_service" {
  value = google_project_service.main
}