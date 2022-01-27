
output "service_account" {
  value = google_service_account.firefly
}

output "project_membership" {
  value = google_project_iam_member.service_account_project_membership
}

output "project_membership_storage_viewer" {
  value = google_project_iam_member.service_account_project_membership_storage_viewer
}

output "project_membership_viewer" {
  value = google_project_iam_member.service_account_project_viewer
}

output "project_service" {
  value = google_project_service.main
}