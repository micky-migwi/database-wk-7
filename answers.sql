-- Transform ProductDetail into 1NF
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (
    SELECT 1 AS n UNION ALL 
    SELECT 2 UNION ALL 
    SELECT 3
) AS n
ON n.n <= (LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1);

-- Table 1: Orders (removes partial dependency)
CREATE TABLE Orders AS
SELECT DISTINCT
    OrderID,
    CustomerName
FROM OrderDetails;

-- Table 2: OrderItems (fully depends on composite key OrderID + Product)
CREATE TABLE OrderItems AS
SELECT
    OrderID,
    Product,
    Quantity
FROM OrderDetails;
