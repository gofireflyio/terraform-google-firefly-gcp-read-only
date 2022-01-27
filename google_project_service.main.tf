resource "google_project_service" "main" {
  count              = length(local.services_list)
  project            = data.google_project.current.project_id
  service            = local.services_list[count.index]
  disable_on_destroy = false
}
