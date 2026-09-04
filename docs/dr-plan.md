# ShopCloud Disaster Recovery Plan

Transactional customer/order/inventory data uses PostgreSQL with automated backups and point-in-time recovery. The target for orders and inventory is RPO near-zero to 5 minutes and RTO about 5 minutes; lower-priority analytics/review data can use longer recovery windows.

Recovery sequence: restore healthy application runtime -> restore/validate database -> verify inventory and order invariants -> rotate/verify secrets -> validate Stripe and shipping providers -> enable traffic -> run checkout smoke tests -> monitor.
