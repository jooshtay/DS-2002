CREATE SCHEMA `Sales`;
use Sales;


# Creating the dimension tables

# Creating the date dimension table
CREATE TABLE dim_date(
	Order_ID int,
    Order_Date text( 20 ) );

# Creating the locaiton dimension table
CREATE TABLE dim_location_purchased(
	Order_ID int,
    Purchase_Address text( 40 ) );

# Creating the prodcut dimension table
CREATE TABLE dim_products(
	Order_ID int,
    Product text( 30 ),
    Price_Each varchar( 10 ) );
    
    
# Populate the dimension tables

# Populating dim_date table
INSERT INTO `Sales`.`dim_date`
	( `Order_ID`,
    `Order_Date` )
    
SELECT 
    `Order ID`, 
    `Order Date`
    
FROM `Sales`.`fact_table`;
    
# Populating dim_location_purchased_table
INSERT INTO `Sales`.`dim_location_purchased`
	( `Order_ID`,
    `Purchase_Address` )
    
SELECT
    `Order ID`,
    `Purchase Address`
    
FROM `Sales`.`fact_table`;


# Populating dim_products table
INSERT INTO `Sales`.`dim_products`
	( `Order_ID`,
     `Product`,
     `Price_Each` )
     
SELECT
	`Order ID`,
    `Product`,
    `Price Each`

FROM `Sales`.`fact_table`;


# Validating the data 

SELECT count(*) from dim_products;

SELECT count(*) from dim_location_purchased;

SELECT count(*) from dim_date;


# Creating the fact table

CREATE TABLE fact_table_intermediary AS 

(SELECT dim_date.*, dim_location_purchased.Purchase_Address

FROM dim_date

INNER JOIN dim_location_purchased

ON dim_date.Order_ID = dim_location_purchased.Order_ID );



# Creating a new fact table

CREATE TABLE new_fact_table AS

(SELECT fact_table_intermediary.* , dim_products.Product , dim_products.Price_Each

FROM fact_table_intermediary

INNER JOIN dim_products

ON fact_table_intermediary.Order_ID = dim_products.Order_ID );

    





    
    

	
