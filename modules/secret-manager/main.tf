resource "google_secret_manager_secret" "cloudsql_db_password" {
  secret_id = var.secret_name

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "cloudsql_db_password_version" {
  secret      = google_secret_manager_secret.cloudsql_db_password.id
  secret_data = var.secret_value
}
