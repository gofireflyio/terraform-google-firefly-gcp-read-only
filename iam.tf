resource "google_service_account" "firefly" {
  display_name = "${data.google_project.current.name}-firefly-access"
  account_id   = "firefly-gcp"
  project      = data.google_project.current.project_id

  depends_on = [google_project_service.main]
}

resource "google_project_iam_member" "service_account_project_membership" {
  project = data.google_project.current.project_id
  role    = "roles/iam.securityReviewer"
  member  = "serviceAccount:${google_service_account.firefly.email}"
}

resource "google_project_iam_member" "service_account_project_membership_storage_viewer" {
  project = data.google_project.current.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.firefly.email}"
}

resource "google_project_iam_member" "service_account_project_viewer" {
  project = data.google_project.current.project_id
  role    = "roles/viewer"
  member  = "serviceAccount:${google_service_account.firefly.email}"
}

resource "google_service_account_key" "credentials" {
  service_account_id = google_service_account.firefly.name
}