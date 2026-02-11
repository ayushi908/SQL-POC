resource "google_compute_global_address" "cloudsql_psa_range" {
  name          = "cloudsql-psa-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_id
}

resource "google_service_networking_connection" "cloudsql_psa_connection" {
  network                 = var.vpc_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.cloudsql_psa_range.name
  ]
}
