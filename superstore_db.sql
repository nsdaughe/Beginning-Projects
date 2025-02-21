SELECT * FROM superstore;

USE superstore_db;

CREATE TABLE dim_product(
	row_id INT PRIMARY KEY,
	product_id VARCHAR(50),
	product_name VARCHAR(200),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    quantity INT
);

CREATE TABLE dim_customer(
	row_id INT PRIMARY KEY,
	customer_id VARCHAR(50),
    customer_name VARCHAR(50),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR (50),
    region VARCHAR(50)
);

CREATE TABLE dim_order(
	order_id VARCHAR(50) PRIMARY KEY,
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(20)
);


CREATE TABLE fact_superstore(
	row_id INT PRIMARY KEY,
	order_id VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    FOREIGN KEY (row_id) REFERENCES dim_product(row_id),
    FOREIGN KEY (row_id) REFERENCES dim_customer(row_id),
    FOREIGN KEY (order_id) REFERENCES dim_order(order_id)
);

INSERT INTO dim_order(order_id, order_date, ship_date, ship_mode)
SELECT DISTINCT 
	order_id,
    order_date,
    ship_date,
    ship_mode
FROM superstore;

INSERT INTO dim_product(row_id, product_id, product_name, category, sub_category, quantity)
SELECT  
	row_id,
	product_id,
    product_name,
    category,
    sub_category,
    quantity
FROM superstore;

INSERT INTO dim_customer(row_id, customer_id, customer_name, segment, country, city, state, region)
SELECT
	row_id,
	customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    region
FROM superstore;


INSERT INTO fact_superstore(row_id, order_id, customer_id, product_id) 
SELECT 
	row_id,
    order_id,
    customer_id,
    product_id
FROM superstore;

