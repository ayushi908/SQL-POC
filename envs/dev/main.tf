module "vpc" {
  source        = "../../modules/vpc"
  vpc_name      = "dev-cloudsql-vpc"
  subnet_name   = "dev-cloudsql-subnet"
  subnet_cidr   = "10.10.0.0/24"
  region        = var.region
}

module "private_service_access" {
  source = "../../modules/private-service-access"
  vpc_id = module.vpc.vpc_id
}

module "db_secret" {
  source       = "../../modules/secret-manager"
  secret_name  = "dev-cloudsql-db-password"
  secret_value = var.db_password
}

module "cloudsql" {
  source                = "../../modules/cloudsql"
  instance_name          = "dev-cloudsql-postgres"
  region                 = var.region
  tier                   = "db-custom-1-3840"
  vpc_id                 = module.vpc.vpc_id
  database_name          = "appdb"
  db_user                = "appuser"
  db_password            = var.db_password
  private_service_access = module.private_service_access
}
