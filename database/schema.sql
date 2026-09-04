CREATE TABLE customers (id UUID PRIMARY KEY, name TEXT NOT NULL, email TEXT UNIQUE NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE products (id UUID PRIMARY KEY, sku TEXT UNIQUE NOT NULL, name TEXT NOT NULL, price NUMERIC(12,2) NOT NULL CHECK (price >= 0), stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0), created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE orders (id UUID PRIMARY KEY, customer_id UUID NOT NULL REFERENCES customers(id), status TEXT NOT NULL CHECK (status IN ('pending','paid','packed','shipped','delivered','cancelled')), total NUMERIC(12,2) NOT NULL CHECK (total >= 0), created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE order_items (order_id UUID REFERENCES orders(id), product_id UUID REFERENCES products(id), quantity INTEGER NOT NULL CHECK (quantity > 0), unit_price NUMERIC(12,2) NOT NULL CHECK (unit_price >= 0), PRIMARY KEY(order_id, product_id));
CREATE INDEX orders_customer_idx ON orders(customer_id, created_at DESC);
