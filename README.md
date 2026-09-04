# Online Shopping Platform

Cloud-native e-commerce portfolio project (ShopCloud) with a React/TypeScript frontend, Node.js/Express API, transactional commerce services, inventory, security, reliability, CI/CD, and a Google Cloud Architect design workbook.

## Architecture

The solution is designed for multi-region deployment with global HTTPS load balancing, Cloud Armor, private services, transactional order/inventory storage, object storage for media and backups, analytics, and disaster recovery.

## Documentation

- `docs/google-cloud-architect-workbook.md` — complete architecture/design workbook
- `docs/architecture.md` — system and reliability architecture
- `docs/api.md` — REST API contract

## Portfolio note

Payment, shipping, search, messaging, and other external integrations are represented by secure adapters/mock boundaries. No production credentials or third-party secrets are included.
