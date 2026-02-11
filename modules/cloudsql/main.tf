resource "google_sql_database_instance" "cloudsql_postgres_instance" {
  name             = var.instance_name
  database_version = "POSTGRES_14"
  region           = var.region

  settings {
    tier = var.tier

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }
  }

  depends_on = [
    var.private_service_access
  ]
}

resource "google_sql_database" "cloudsql_app_database" {
  name     = var.database_name
  instance = google_sql_database_instance.cloudsql_postgres_instance.name
}

resource "google_sql_user" "cloudsql_app_user" {
  name     = var.db_user
  instance = google_sql_database_instance.cloudsql_postgres_instance.name
  password = var.db_password
}
