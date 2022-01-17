module "firefly" {
  source                = "../../"
  firefly_access_key    = "INFLXXXXXX"
  firefly_secret_key    = "XXXXXXXXX"
  name                  = "example-integration"
  project_id            = "example-12345"
}