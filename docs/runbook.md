# ShopCloud Operations Runbook

## Health
Cloud Run probes `/healthz` and `/readyz`.

## Deploy
Build and scan the immutable container, push to Artifact Registry, apply reviewed Terraform, migrate the database, then smoke-test auth, catalogue, inventory reservation, checkout and payment webhooks.

## Rollback
Roll back the application image first. Database changes must remain backward compatible; use forward migrations for schema repair.

## Incident response
Use correlation IDs and structured Cloud Logging to trace failed checkout/order flows. Check database locks/connection saturation, inventory reservation failures, Stripe webhook delivery and shipping-provider errors before changing order state.
