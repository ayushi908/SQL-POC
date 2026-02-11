output "private_ip" {
  value = google_sql_database_instance.cloudsql_postgres_instance.private_ip_address
}
