CREATE DATABASE IF NOT EXISTS electronics_retail;

USE electronics_retail;

CREATE TABLE dim_country(
 country_id INT PRIMARY KEY,
 country_code VARCHAR(100),
 country_name VARCHAR(100),
 region_code VARCHAR(100)
 );

CREATE TABLE dim_state(
 state_id INT PRIMARY KEY,
 state_code VARCHAR(100),
 state_name VARCHAR(100),
 country_id INT,
 FOREIGN KEY (country_id) REFERENCES dim_country(country_id)
);

CREATE TABLE dim_city(
 city_id INT PRIMARY KEY,
 city_name VARCHAR(100),
 state_id INT,
 FOREIGN KEY (state_id) REFERENCES dim_state(state_id)
);

CREATE TABLE dim_address(
 address_id INT PRIMARY KEY,
 address VARCHAR(150),
 postal_code VARCHAR(100),
 city_id INT,
 FOREIGN KEY (city_ID) REFERENCES dim_city(city_id)
 );

CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    customer_code VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(50),
    unknown_dob DATE,
    gender VARCHAR(10),
    customer_segment VARCHAR(50),
    registration_date DATE,
    is_active BOOLEAN,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES dim_address(address_id),
    preferred_contact_method VARCHAR(50)
);

ALTER TABLE dim_customer
DROP COLUMN unknown_dob;

CREATE TABLE dim_salesperson (
    salesperson_id INT PRIMARY KEY,
    employee_code VARCHAR(20),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    hire_date DATE,
    department VARCHAR(50),
    job_title VARCHAR(50),
    manager_id INT,
    is_active BOOLEAN
);

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_code VARCHAR(20),
    store_name VARCHAR(100),
    store_type VARCHAR(30),
    phone VARCHAR(20),
    store_email VARCHAR(100),
    manager_name VARCHAR(100),
    manager_contact VARCHAR(20),
    salesperson_id INT,
    opening_date DATE,
    closing_date DATE,
    square_footage INT,
    parking_spaces INT,
    employee_count INT,
    operating_hours VARCHAR(20),
    has_online_pickup BOOLEAN,
    is_active BOOLEAN
);

ALTER TABLE dim_store
ADD FOREIGN KEY (salesperson_id) REFERENCES dim_salesperson(salesperson_id);

CREATE TABLE dim_order (
    order_id INT PRIMARY KEY,
    order_number VARCHAR(50),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    order_date DATE,
    order_status VARCHAR(50),
    payment_status VARCHAR(50),
    channel VARCHAR(50),
    unknown_sub_channel VARCHAR(50),
    unknown_device_type VARCHAR(50),
    shipping_method VARCHAR(50),
    unknown_col12 INT,
    shipped_date DATETIME,
    delivery_date DATETIME,
    expected_delivery_date DATE,
    tracking_number VARCHAR(50),
    unknown_courier VARCHAR(50),
    coupon_code VARCHAR(50),
    total_item INT,
    grand_total DECIMAL(12,2),
    discount_total DECIMAL(12,2),
    tax_total DECIMAL(12,2),
    shipping_cost DECIMAL(10,2),
    shipping_total DECIMAL(10,2),
    priority_order BOOLEAN,
    is_express_delivery BOOLEAN,
    unknown_col27 BOOLEAN,
    cancelled_at DATETIME,
    refunded_at DATETIME
    );
    
    ALTER TABLE dim_order
    MODIFY cancelled_at DATE,
    MODIFY refunded_at DATE,
    MODIFY order_date DATE,
    MODIFY shipped_date DATE,
    MODIFY delivery_date DATE,
    MODIFY expected_delivery_date DATE;
    
CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_code VARCHAR(50),
    product_name VARCHAR(100),
    product_discription TEXT,
    category VARCHAR(50),
    subcategory VARCHAR(50),
    brand VARCHAR(50),
    supplier VARCHAR(100),
    unit_cost DECIMAL(12,2),
    unit_price DECIMAL(12,2),
    weight DECIMAL(8,2),
    size VARCHAR(50),
    color VARCHAR(50),
    material VARCHAR(50),
    warranty_months INT,
    reorder_level INT,
    stock_quantity INT
);

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    quarter INT,
    year INT,
    day_of_week INT,
    day_name VARCHAR(50),
    month_name VARCHAR(50),
    is_weekend BOOLEAN,
    is_holiday BOOLEAN,
    fiscal_year INT,
    fiscal_quarter INT
);

CREATE TABLE fact_sales (
    sales_id BIGINT PRIMARY KEY,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES dim_order(order_id),
    date_id INT,
	FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    customer_id INT,
	FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    product_id INT,
	FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    salesperson_id INT,
	FOREIGN KEY (salesperson_id) REFERENCES dim_salesperson(salesperson_id),
    quantity DECIMAL(10,2),
    unit_price DECIMAL(12,2),
    discount_amount DECIMAL(12,2),
    unknown_discount_rate DECIMAL(5,2),
    profit_amount DECIMAL(12,2),
    cost_amount DECIMAL(12,2),
    total_amount DECIMAL(12,2),
    unknown_Q DECIMAL(12,2),
    tax_amount DECIMAL(12,2),
    unknown_tax_rate DECIMAL(5,2)
    
);
