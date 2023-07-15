

-- customers who purchased 
-- the product named '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' buy the product below or not.  
-- 1. 'Polk Audio - 50 W Woofer - Black' -- (other_product)

WITH T1 AS (
SELECT c.customer_id, p.product_name, 'YES' Other_Product
FROM sale.orders o, sale.order_item oo, sale.customer c, product.product p
WHERE o.order_id=oo.order_id AND c.customer_id=o.customer_id AND p.product_id=oo.product_id 
AND product_name='2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'),
t2 as(
SELECT c.customer_id, c.first_name, c.last_name
FROM sale.orders o, sale.order_item oo, sale.customer c, product.product p
WHERE o.order_id=oo.order_id AND c.customer_id=o.customer_id AND p.product_id=oo.product_id 
AND product_name='Polk Audio - 50 W Woofer - Black')
SELECT t2.customer_id, t2.first_name, t2.last_name, COALESCE(Other_Product, 'NO') Other_Product
FROM T2
LEFT JOIN t1 ON t2.customer_id=t1.customer_id 

------------------------------------------------------------------------------

--Table Creation

CREATE TABLE e_commerce
(
  Visitor_ID INT,
  Adv_Type VARCHAR(10),
  Action VARCHAR(10)
);

INSERT INTO e_commerce VALUES
 (1, 'A', 'Left'),
 (2, 'A', 'Order'),
 (3, 'B', 'Left'),
 (4, 'A', 'Order'),
 (5, 'A', 'Review'),
 (6, 'A', 'Left'),
 (7, 'B', 'Left'),
 (8, 'B', 'Order'),
 (9, 'B', 'Review'),
 (10, 'A', 'Review');


 -- count of total Actions and Orders for each Advertisement Type
 WITH T1 AS
 (SELECT e.Adv_Type, COUNT(action) order_count
 FROM e_commerce e
 WHERE Action='order'
 GROUP BY e.Adv_Type),
 T2 AS(
 SELECT adv_type, COUNT(Action) Total_Action
 FROM e_commerce
 GROUP BY adv_type)
 SELECT distinct t1.Adv_Type, Total_Action, order_count
 FROM e_commerce, t1, t2
 WHERE e_commerce.Adv_Type=t1.Adv_Type AND e_commerce.Adv_Type=t2.Adv_type

 -- Calculation of Conversion Rates
 
 with t1 as(
 SELECT Adv_Type,cast(count(action) as int) total_order, 
 (SELECT cast(COUNT(ACTION) as int) FROM e_commerce) Total_Visitor
 FROM e_commerce
 WHERE Action='order'
 group by Adv_Type)
 SELECT *, cast((total_order*1.0)/(Total_Visitor*1.0) as decimal (10,2)) conversion_rate
 FROM t1









 
 