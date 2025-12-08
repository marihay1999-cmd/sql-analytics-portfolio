CREATE TABLE IF NOT EXISTS employees (
  employee_id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  email TEXT,
  salary NUMERIC
);

CREATE TABLE IF NOT EXISTS customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name TEXT,
  address TEXT,
  city TEXT,
  zip_code TEXT
);

CREATE TABLE IF NOT EXISTS products (
  product_id INTEGER PRIMARY KEY,
  product_name TEXT,
  price NUMERIC,
  description TEXT,
  category TEXT
);

CREATE TABLE IF NOT EXISTS orders (
  order_id INTEGER PRIMARY KEY,
  order_date TIMESTAMP,
  year INT,
  quarter INT,
  month TEXT
);

CREATE TABLE IF NOT EXISTS sales (
  transaction_id INTEGER PRIMARY KEY,
  order_id INTEGER REFERENCES orders(order_id) ON DELETE RESTRICT,
  product_id INTEGER REFERENCES products(product_id) ON DELETE RESTRICT,
  customer_id INTEGER REFERENCES customers(customer_id) ON DELETE RESTRICT,
  employee_id INTEGER REFERENCES employees(employee_id) ON DELETE SET NULL,
  total_sales NUMERIC,
  quantity INTEGER,
  discount NUMERIC
);

CREATE TABLE IF NOT EXISTS employees (
  employee_id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  email TEXT,
  salary NUMERIC
);
