# ShopCloud Production Readiness Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a secure, tested and deployment-ready ShopCloud commerce platform with real identity, payment, shipping and cloud integrations.

**Architecture:** Preserve the current Node.js/domain structure while adding focused repositories, provider adapters, transaction-safe checkout and secure infrastructure. PostgreSQL is the source of truth for customers, orders and inventory; managed search/media/notification providers are accessed through replaceable interfaces.

**Tech Stack:** Node.js, PostgreSQL, Firebase Admin, Stripe, shipping-provider adapter, Cloud Storage, Docker, Terraform, GitHub Actions.

**Spec:** `docs/superpowers/specs/2026-09-04-shopcloud-production-readiness-design.md`

## Global Constraints
- No secrets or production credentials in Git.
- Payment card data never enters the application database.
- Every external integration has a testable adapter boundary.
- Checkout and inventory reservation must be transaction-safe and idempotent.
- Production deployment requires health/readiness checks and automated tests.

---

### Task 1: Production configuration and HTTP foundation
**Files:** Create `src/config.js`, `src/http.js`, `src/middleware/security.js`, `test/config.test.js`, `test/http.test.js`; modify `package.json`.
- [ ] Write failing configuration and health/readiness tests.
- [ ] Confirm RED.
- [ ] Implement validated environment configuration, correlation IDs, security headers, CORS and rate limiting.
- [ ] Confirm GREEN.
- [ ] Commit configuration foundation.

### Task 2: PostgreSQL schema and repositories
**Files:** Create `database/migrations/001_production.sql`, `database/seed.sql`, `src/db.js`, `src/repositories/productRepository.js`, `src/repositories/orderRepository.js`, `src/repositories/inventoryRepository.js`, repository tests.
- [ ] Write failing tests for product reads, stock reservation and order persistence.
- [ ] Confirm RED.
- [ ] Implement parameterized SQL, constraints, indexes and transaction boundaries.
- [ ] Confirm GREEN.
- [ ] Commit persistence layer.

### Task 3: Inventory reservation and checkout state machine
**Files:** Create `src/services/inventoryService.js`, `src/services/checkoutService.js`, `src/services/orderService.js`, tests.
- [ ] Write failing tests for concurrent-safe reservation, insufficient stock, idempotent checkout and legal order transitions.
- [ ] Confirm RED.
- [ ] Implement row locking/transaction semantics and state machine.
- [ ] Confirm GREEN.
- [ ] Commit commerce workflow.

### Task 4: Identity integration
**Files:** Create `src/integrations/identity/firebaseVerifier.js`, `src/middleware/auth.js`, `test/auth.test.js`, `.env.example` update.
- [ ] Write failing valid/expired/missing-token tests.
- [ ] Confirm RED.
- [ ] Implement Firebase Admin verification with dependency injection.
- [ ] Confirm GREEN.
- [ ] Commit identity integration.

### Task 5: Stripe payments and webhooks
**Files:** Create `src/integrations/payments/stripeProvider.js`, `src/routes/paymentWebhook.js`, `src/services/paymentService.js`, payment tests.
- [ ] Write failing tests for PaymentIntent idempotency, success and invalid webhook signature.
- [ ] Confirm RED.
- [ ] Implement Stripe PaymentIntents and signed webhook processing.
- [ ] Confirm GREEN.
- [ ] Commit payment integration.

### Task 6: Shipping, notifications and media
**Files:** Create `src/integrations/shipping/provider.js`, `src/integrations/shipping/httpProvider.js`, `src/integrations/notifications/*`, `src/integrations/storage/cloudStorageProvider.js`, tests and integration setup docs.
- [ ] Write provider contract tests.
- [ ] Confirm RED.
- [ ] Implement replaceable providers with timeout/retry policy and fake test providers.
- [ ] Confirm GREEN.
- [ ] Commit external integrations.

### Task 7: Search/catalogue and API assembly
**Files:** Create `src/services/catalogService.js`, `src/services/searchService.js`, route modules, `docs/openapi.yaml`, `test/api.test.js`.
- [ ] Write API tests for authenticated cart, product search, checkout and order retrieval.
- [ ] Confirm RED.
- [ ] Wire routes, validation, pagination and OpenAPI contracts.
- [ ] Confirm GREEN.
- [ ] Commit API assembly.

### Task 8: Docker, CI and security scanning
**Files:** Modify `Dockerfile`, `.dockerignore`, `.github/workflows/ci.yml`; create `scripts/healthcheck.js`.
- [ ] Add CI gates for tests, lint/type/security checks.
- [ ] Implement multi-stage non-root container and deterministic build.
- [ ] Run test suite and Docker build if available.
- [ ] Commit delivery pipeline.

### Task 9: Terraform/GCP deployment baseline
**Files:** Create `infra/terraform/main.tf`, `variables.tf`, `outputs.tf`, modules for network, Cloud Run, Cloud SQL, Artifact Registry, Secret Manager and monitoring; create `docs/deployment.md`.
- [ ] Add infrastructure validation tests/checks.
- [ ] Implement least-privilege service accounts, private DB connectivity, secret bindings and autoscaling configuration.
- [ ] Validate Terraform format and plan syntax without applying resources.
- [ ] Commit infrastructure.

### Task 10: Operations, backup/DR and final verification
**Files:** Create `docs/runbook.md`, `docs/integration-setup.md`, `docs/dr-plan.md`, `docs/security.md`.
- [ ] Document provider setup, secret names, migration/rollback, backup/PITR, alerts and incident response.
- [ ] Run complete tests and inspect GitHub Actions status.
- [ ] Verify no secret-like values are committed.
- [ ] Commit operational readiness and verify remote repository state.
