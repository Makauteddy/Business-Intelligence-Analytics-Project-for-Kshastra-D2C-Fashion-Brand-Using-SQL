CREATE TABLE customers(
Customer_ID VARCHAR(50),
Name VARCHAR(50),
First_order DATE,
Total_orders INT,
Total_revenue TEXT,
Average_order_value DECIMAL(10,2),
Time_to_2nd_purchase DECIMAL(10, 2),
Last_purchase DATE,
City VARCHAR(50),
Tier VARCHAR(50),
Acquisition_channel  VARCHAR(50),
RePurchased VARCHAR(50)
);

CREATE TABLE inventory_data(
SKU VARCHAR(50),
Category VARCHAR(50),
Size VARCHAR(50),
Units_in_stock INT,
Days_of_inventory_left DECIMAL(10,2),
Dead_stock_flag VARCHAR(50),
date DATE
);

CREATE TABLE ORDERS(
Order_ID VARCHAR(50),
Customer_ID	VARCHAR(50),
Order_date  DATE,	
Product	VARCHAR(50),
Order_value_gross INT,
Order_value_net INT,
Discount_applied VARCHAR(50),	
Payment_mode	VARCHAR(50),
Shipping_city VARCHAR(50),
Pincode	INT,
First_order_vs_repeat VARCHAR(50),
Channel_source_last_touch VARCHAR(50),
Delivered_Returned_RTO VARCHAR(50)
);

CREATE TABLE ORDER_LINE_ITEMS(
OrderID VARCHAR(50),
SKU ID	VARCHAR(50),
Category VARCHAR(50),
Size VARCHAR(50),
Color VARCHAR(50),
MRP	INT,
Selling price INT,
Discount_% INT,
Returned? (Y/N) VARCHAR(50),
Return_reason VARCHAR(50)
);

CREATE TABLE purchase_order (
SKU	VARCHAR(50),
Vendor VARCHAR(50),
Order_quantity INT,
Cost_per_unit INT,
Order_date	DATE,
Expected_delivery DATE,
Actual_delivery DATE,
Lead_time INT
);

CREATE TABLE meta_ads (
date DATE,
campaign_name VARCHAR(50),
adset_name	VARCHAR(50),
Results INT,
Amount_spent  INT,
spend INT,
Reach INT,
impressions INT,
frequency DECIMAL(10,2),
link_clicks INT,
ctr_link DECIMAL(10,2),
add_to_cart	INT,
initiate_checkout INT,
purchases INT,
purchase_conversion_value DECIMAL(10,2),
cac DECIMAL(10,2),
roas DECIMAL(10,2),
creative_type VARCHAR(50),
launch_date	 DATE,
Hook_Rate DECIMAL(10,2)
);

CREATE TABLE Website_data(
date DATE,
traffic_source VARCHAR(50),
campaign_name VARCHAR(50),
device_category VARCHAR(50),
sessions INT,
product_views INT,
add_to_cart	INT,
begin_checkout INT,
purchases INT,
revenue	DECIMAL(10,2),
conversion_rate DECIMAL(10,2),
aov	DECIMAL(10,2),
country VARCHAR(50),
city VARCHAR(50),
purchased INT
);


   