DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers (
  customer_id SERIAL4 PRIMARY KEY,
  customer_name VARCHAR(255),
  customer_funds INT4
);

CREATE TABLE films (
  film_id SERIAL4 PRIMARY KEY,
  film_title VARCHAR(255),
  film_price INT4
);

CREATE TABLE tickets (
  ticket_id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(customer_id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(film_id) ON DELETE CASCADE
);