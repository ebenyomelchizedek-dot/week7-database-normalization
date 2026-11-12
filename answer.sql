
-- WEEK 7 ASSIGNMENT: DATABASE DESIGN AND NORMALIZATION

CREATE DATABASE IF NOT EXISTS week7_normalization;
USE week7_normalization;

-- Remove existing tables before rebuilding the assignment
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ProductDetail;


-- QUESTION 1: ACHIEVING FIRST NORMAL FORM (1NF)

-- Each row contains only one product per order.

CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product)
);

-- Insert normalized product records

INSERT INTO ProductDetail (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Display Question 1 results

SELECT *
FROM ProductDetail
ORDER BY OrderID, Product;


-- QUESTION 2: ACHIEVING SECOND NORMAL FORM (2NF)

-- Partial dependency identified:
-- CustomerName depends only on OrderID,
-- not on the complete composite key (OrderID, Product).

-- Create Orders table

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert order records

INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert order item records

INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Display Orders table

SELECT * FROM Orders;

-- Display OrderItems table

SELECT * FROM OrderItems
ORDER BY OrderID, Product;

-- Display complete order information using INNER JOIN

SELECT
    Orders.OrderID,
    Orders.CustomerName,
    OrderItems.Product,
    OrderItems.Quantity
FROM Orders
INNER JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID
ORDER BY Orders.OrderID, OrderItems.Product;
