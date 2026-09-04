# ShopCloud Integration Setup

## Required production services
Use a GCP project with Cloud Run, Artifact Registry, Cloud SQL/PostgreSQL and Secret Manager. Configure Firebase/Google Identity Platform for customer authentication, Stripe for PaymentIntents/webhooks, and a shipping provider compatible with the adapter contract. Cloud Storage can be used for product media.

## Runtime secrets
Inject `DATABASE_URL`, `FIREBASE_PROJECT_ID`, `STRIPE_SECRET_KEY`, `STRIPE_WEBHOOK_SECRET`, `SHIPPING_API_KEY` and `STORAGE_BUCKET` through deployment secrets. Never commit real values.

## Checkout flow
Customer -> authenticated cart -> transactional inventory reservation -> order creation -> Stripe PaymentIntent -> verified webhook -> order state transition -> shipping fulfillment. Idempotency keys prevent duplicate checkout/payment effects.
