output "secret_id" {
  value = google_secret_manager_secret.cloudsql_db_password.id
}
