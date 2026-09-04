terraform { required_version=">= 1.6.0" required_providers { google={source="hashicorp/google" version="~> 6.0"} } }
provider "google" { project=var.project_id region=var.region }
resource "google_artifact_registry_repository" "shopcloud" { location=var.region repository_id="shopcloud" format="DOCKER" }
resource "google_service_account" "api" { account_id="shopcloud-api" display_name="ShopCloud API runtime" }
resource "google_secret_manager_secret" "stripe" { secret_id="shopcloud-stripe-secret" replication { auto {} } }
resource "google_cloud_run_v2_service" "api" { name="shopcloud-api" location=var.region deletion_protection=false template { service_account=google_service_account.api.email containers { image=var.container_image ports { container_port=8080 } startup_probe { http_get { path="/readyz" } initial_delay_seconds=5 period_seconds=10 } liveness_probe { http_get { path="/healthz" } period_seconds=30 } } } }
output "service_url" { value=google_cloud_run_v2_service.api.uri }
