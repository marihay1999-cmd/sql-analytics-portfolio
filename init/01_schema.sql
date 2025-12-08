CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  email TEXT,
  salary NUMERIC
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name TEXT,
  address TEXT,
  city TEXT,
  zip_code TEXT
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name TEXT,
  price NUMERIC,
  description TEXT,
  category TEXT
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  order_date TIMESTAMP,
  year INT,
  quarter INT,
  month TEXT
);

CREATE TABLE sales (
  transaction_id INTEGER PRIMARY KEY,
  order_id INTEGER REFERENCES orders(order_id),
  product_id INTEGER REFERENCES products(product_id),
  customer_id INTEGER REFERENCES customers(customer_id),
  employee_id INTEGER REFERENCES employees(employee_id),
  total_sales NUMERIC,
  quantity INTEGER,
  discount NUMERIC
);
