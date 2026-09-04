# ShopCloud REST API

Base path: `/api/v1`. JSON over HTTPS. Bearer authentication is required except login/refresh.

| Resource | Methods |
|---|---|
| `/auth/login`, `/auth/refresh` | POST |
| `/customers`, `/customers/{id}` | GET, POST, PATCH |
| `/products`, `/products/{id}` | GET, POST, PATCH |
| `/categories` | GET, POST |
| `/cart`, `/cart/items/{id}` | GET, POST, PATCH, DELETE |
| `/orders`, `/orders/{id}` | GET, POST, PATCH |
| `/inventory/{sku}` | GET, POST, PATCH |
| `/payments` | GET, POST |
| `/shipments` | GET, POST, PATCH |
| `/products/{id}/reviews` | GET, POST |
| `/notifications` | GET, POST |
| `/tickets`, `/tickets/{id}` | GET, POST, PATCH |
| `/events` | POST |

Design rules: idempotency keys for checkout/payment, pagination, validation, structured errors, correlation IDs, rate limiting and audit events.
