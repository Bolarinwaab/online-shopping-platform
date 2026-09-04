# ShopCloud Production Readiness Design

## Goal
Turn the existing ShopCloud portfolio application into a deployment-ready commerce service with real integration boundaries for identity, catalogue, inventory, checkout, payments, shipping, notifications, media and cloud operations.

## Architecture
The first production deployment will use Node.js with PostgreSQL for transactional customer/order/inventory data and a search/media abstraction that can use managed services in GCP. Inventory reservation and checkout will execute transactionally so concurrent purchases cannot oversell stock. External services are isolated behind adapters, with deterministic fakes for automated tests and runtime credentials from Secret Manager.

Authentication uses Firebase/Google Identity Platform token verification. Stripe provides payment intents and signed webhooks. Shipping uses a provider adapter suitable for Shippo/EasyPost-style APIs without coupling the domain to one vendor. Product media uses signed Cloud Storage URLs. Notifications use replaceable email/SMS/push adapters.

## Required capabilities
- Configuration validation with fail-fast startup and no committed secrets.
- Health/readiness endpoints, structured logging and request correlation.
- Security headers, CORS allowlist, rate limiting and input validation.
- Idempotent checkout/payment/webhook processing.
- Transaction-safe inventory reservation and order state machine.
- PostgreSQL migrations, constraints and indexes.
- Stripe payment integration and webhook verification.
- Shipping-provider integration boundary.
- Product media upload/download boundary for Cloud Storage.
- Search/filter service abstraction.
- Docker hardening and CI checks.
- Terraform/GCP deployment baseline with Secret Manager references.
- Unit, integration and API contract tests.
- Operational runbook, SLOs, backup/PITR and DR documentation.

## Security constraints
No payment secrets, API keys, service-account private keys, passwords or production tokens may be committed. Stripe handles card collection; card numbers and security codes are never stored by the application.

## Production activation boundary
The repository will be production-ready and deployment-ready. Live activation still requires the operator's cloud project/billing account, domain and provider credentials, configured outside Git and injected securely at runtime.
