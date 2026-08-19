-- 1. How has kshastra’s total sales revenue and order volume grown from 2022 to 2025?
SELECT
	EXTRACT(YEAR FROM order_date) AS Year,
	COUNT(order_id) AS Total_orders,
	SUM(order_value_net) AS Total_revenue,
	ROUND(AVG(order_value_net),2) AS AVG_order_value
FROM orders
GROUP BY Year
ORDER BY Year;

--2. Which products and categories generate the highest revenue?
SELECT
	product,
	SUM(order_value_net) AS revenue,
	COUNT(order_id) AS Orders
FROM orders
GROUP BY product
ORDER BY revenue DESC;

SELECT 
	category,
	SUM(selling_price) AS Revenue,
	COUNT(*) AS units_sold
FROM order_line_items
GROUP BY category
ORDER BY revenue DESC;

-- 3. Which cities contribute the highest sales revenue and order volume?
SELECT
	shipping_city,
	COUNT(order_id) AS Total_orders,
	SUM(order_value_net) AS Total_revenue,
	ROUND(AVG(order_value_net),2) AS AVG_order_value
FROM orders
GROUP BY shipping_city
ORDER BY  Total_revenue;

-- 4. What is the average order value over time, and which products have the highest AOV?
SELECT 
	DATE_TRUNC('month', order_date) AS month,
	ROUND(AVG(order_value_net),2) AS AVG_order_value
FROM orders
GROUP BY month
ORDER BY month;

SELECT 
	product,
	ROUND(AVG(order_value_net),2) AS AVG_order_value
	FROM orders
GROUP BY product
ORDER BY AVG_order_value DESC;

-- 5. Which Meta advertising campaigns generate the highest ROAS?
SELECT 
	campaign_name,
	SUM(spend) AS Total_spend,
	SUM(purchase_conversion_value) AS revenue_generated,
	ROUND(SUM(purchase_conversion_value)/ NULLIF(SUM(spend),0),2) AS ROAS
FROM meta_ads
GROUP BY campaign_name
ORDER BY  ROAS DESC;

-- 6. Which campaigns acquire customers at the lowest CAC?
SELECT
	campaign_name,
	ROUND(AVG(cac),2) AS AVG_cac,
	SUM(purchases) AS Total_purchases
FROM meta_ads
GROUP BY campaign_name
ORDER BY AVG_cac ASC;

-- 7. Which creative types achieve the highest CTR, purchases, and conversion value

SELECT
	creative_type,
	ROUND(AVG(ctr_link),2) AS AVG_ctr,
	SUM(purchases) AS Total_purchases,
	SUM(purchase_conversion_value) AS Total_conversion_value,
	ROUND(AVG(roas),2) AS AVG_ROAS
FROM meta_ads
GROUP BY creative_type
ORDER BY AVG_ROAS DESC;

-- 8. Which traffic sources generate the highest website conversion rates and revenue?

SELECT 
	traffic_source,
	SUM(sessions) AS Sessions,
	SUM(purchases) AS Purchases,
	SUM(revenue) AS Revenue,
	ROUND(AVG(conversion_rate),2) AS AVG_conversion_rate
FROM website_data
GROUP BY traffic_source
ORDER BY Revenue DESC;

-- 9. What is the overall repeat purchase rate from 2022 to 2025?

SELECT
	ROUND(SUM(CASE
					WHEN repurchased = 'Y' THEN 1 ELSE 0 END) * 100/COUNT(*),2) AS Repeated_purchase_rate
FROM customers;

-- 10. Which acquisition channels bring the highest lifetime value customers?

SELECT
	acquisition_channel,
	COUNT(customer_id) AS Customers,
	ROUND(AVG(Total_revenue),2) AS AVG_ltv,
	ROUND(AVG(Total_orders),2) AS AVG_orders
FROM customers
GROUP BY acquisition_channel
ORDER BY AVG_ltv DESC;

-- 11. How long does it take customers to make a second purchase?

SELECT 
	ROUND(AVG(time_to_2nd_purchase),2) AS AVG_days_Repurchase
FROM customers
WHERE repurchased = 'Y';

-- 12. Which cities and customer tiers have the highest repeat purchase rates and lifetime value?
SELECT
    city,
	tier,
    ROUND(
        SUM(CASE WHEN repurchased = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS repeat_purchase_rate,
    ROUND(AVG(total_revenue), 2) AS average_ltv
FROM customers
GROUP BY city,tier
ORDER BY average_ltv DESC;

-- 13. Which SKUs and categories are currently flagged as dead stock?
SELECT
    category,
    COUNT(*) AS dead_stock_skus,
    SUM(units_in_stock) AS units_in_stock
FROM inventory_data
WHERE dead_stock_flag = 'Y'
GROUP BY category
ORDER BY dead_stock_skus DESC;


-- 14. Which products are most at risk of stock outs?
	
SELECT
    sku,
    category,
    size,
    units_in_stock,
    days_of_inventory_left
FROM inventory_data
WHERE days_of_inventory_left <= 7
ORDER BY days_of_inventory_left ASC;

-- 15. Which vendors consistently deliver purchase orders on time?

SELECT
    vendor,
    COUNT(*) AS purchase_orders,
    ROUND(
        SUM(CASE WHEN actual_delivery <= expected_delivery THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS on_time_delivery_rate
FROM purchase_order
GROUP BY vendor
ORDER BY on_time_delivery_rate DESC;


-- 16. Which vendors have the longest lead times?
	
SELECT
    vendor,
    ROUND(AVG(lead_time), 2) AS average_lead_time_days,
    MAX(lead_time) AS longest_lead_time
FROM purchase_order
GROUP BY vendor
ORDER BY average_lead_time_days DESC;

-- 17. Which product categories have the highest return rates.

SELECT
    category,
    COUNT(*) AS total_items,
    SUM(CASE WHEN returned = 'Y' THEN 1 ELSE 0 END) AS returned_items,
    ROUND(
        SUM(CASE WHEN returned = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS return_rate_percent
FROM order_line_items
GROUP BY category
ORDER BY return_rate_percent DESC;

-- 18. What are the most common return reasons, and which products are affected the most?

SELECT
    return_reason,
    category,
    COUNT(*) AS return_count
FROM order_line_items
WHERE returned = 'Y'
GROUP BY return_reason, category
ORDER BY return_count DESC;

-- 19. Which combination of marketing channel, product category, and city generates the highest revenue with the lowest return risk?
SELECT
    c.acquisition_channel,
    o.shipping_city,
    oli.category,
    SUM(o.order_value_net) AS total_revenue,
    ROUND(
        SUM(CASE WHEN oli.returned = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS return_rate_percent
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_line_items oli
    ON o.order_id = oli.order_id
GROUP BY c.acquisition_channel, o.shipping_city, oli.category
HAVING COUNT(*) >= 20
ORDER BY total_revenue DESC, return_rate_percent ASC;














