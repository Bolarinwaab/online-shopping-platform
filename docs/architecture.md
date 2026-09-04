# ShopCloud Architecture

## Runtime
Global HTTPS Load Balancer -> Cloud Armor -> API Gateway -> private commerce services deployed across two regions. Stateless APIs autoscale across zones; Pub/Sub decouples order events, notifications and analytics.

## Data
Cloud SQL handles identity/customer data; Spanner handles orders and inventory requiring strong consistency; Firestore handles flexible catalogue/cart documents; Cloud Storage holds product media and backups; BigQuery handles analytics. Bigtable is available for future high-volume telemetry.

## Reliability
Multi-zone compute, health checks, autoscaling, global routing, CDN caching, transactional multi-region data and tested DR procedures.

## Security
TLS, least-privilege IAM/service accounts, private databases, Secret Manager, firewall segmentation, controlled egress, audit logging and Cloud Armor. No secrets are committed.
