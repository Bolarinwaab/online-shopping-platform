terraform { required_version=">= 1.6.0" required_providers { google={source="hashicorp/google" version="~> 6.0"} } }
provider "google" { project=var.project_id region=var.region }
resource "google_artifact_registry_repository" "shopcloud" { location=var.region repository_id="shopcloud" format="DOCKER" }
resource "google_service_account" "api" { account_id="shopcloud-api" display_name="ShopCloud API runtime" }
resource "google_secret_manager_secret" "stripe" { secret_id="shopcloud-stripe-secret" replication { auto {} } }
resource "google_secret_manager_secret_iam_member" "stripe_access" { secret_id=google_secret_manager_secret.stripe.id role="roles/secretmanager.secretAccessor" member="serviceAccount:${google_service_account.api.email}" }
resource "google_sql_database_instance" "postgres" { name="shopcloud-postgres" database_version="POSTGRES_16" region=var.region deletion_protection=true settings { tier="db-custom-2-7680" availability_type="REGIONAL" backup_configuration { enabled=true point_in_time_recovery_enabled=true } ip_configuration { ipv4_enabled=true } } }
resource "google_sql_database" "app" { name="shopcloud" instance=google_sql_database_instance.postgres.name }
resource "google_cloud_run_v2_service" "api" { name="shopcloud-api" location=var.region deletion_protection=false template { service_account=google_service_account.api.email containers { image=var.container_image ports { container_port=8080 } startup_probe { http_get { path="/readyz" } initial_delay_seconds=5 period_seconds=10 } liveness_probe { http_get { path="/healthz" } period_seconds=30 } } } }
output "service_url" { value=google_cloud_run_v2_service.api.uri }
output "database_instance" { value=google_sql_database_instance.postgres.connection_name }
