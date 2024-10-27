drop database if exists db;
CReate DATABASE DB;
USE DB;


DROP table if exists customers;
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    RegistrationDate DATE
);

-- Insert data into Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, RegistrationDate) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '2024-09-01'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '2024-09-02'),
('Emily', 'Jones', 'emily.jones@example.com', '555-8765', '2024-09-03'),
('Michael', 'Brown', 'michael.brown@example.com', '555-4321', '2024-09-04'),
('Laura', 'Wilson', 'laura.wilson@example.com', '555-1357', '2024-09-05');


-- Create Products table
DROP table if exists Products;
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT DEFAULT 0,
    Category VARCHAR(50)
);
-- Insert data into Products
INSERT INTO Products (ProductName, Description, Price, StockQuantity, Category) VALUES
('Laptop', '15-inch laptop with 16GB RAM and 512GB SSD', 999.99, 50, 'Electronics'),
('Smartphone', 'Latest model smartphone with 128GB storage', 499.99, 100, 'Electronics'),
('Headphones', 'Noise-cancelling over-ear headphones', 149.99, 75, 'Accessories'),
('Office Chair', 'Ergonomic office chair with lumbar support', 299.99, 20, 'Furniture'),
('Desk Lamp', 'Adjustable desk lamp with LED light', 89.99, 30, 'Furniture');

-- Create Orders table
DRop table if exists Orders;
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status varchar(11) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into Orders
INSERT INTO Orders (CustomerID, OrderDate, Status) VALUES
(1, '2024-08-01', 'Shipped'),
(2, '2024-08-15', 'Delivered'),
(3, '2024-08-20', 'Pending'),
(1, '2024-08-25', 'Cancelled'),
(4, '2024-08-28', 'Shipped');

DRop table if exists OrderItems;
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT DEFAULT 1,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert data into OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 999.99),
(1, 3, 2, 149.99),
(2, 2, 1, 499.99),
(2, 4, 1, 299.99),
(3, 5, 1, 89.99),
(4, 1, 1, 999.99),
(5, 4, 1, 299.99);




-- DQL-Data Query Language 

-- SELECT Queries
-- List all products with their names and prices:
SELECT ProductName, Price
FROM Products;

-- Retrieve the order dates and statuses for all orders:
SELECT OrderDate, Status
FROM Orders;

-- Get all customer phone numbers and their email addresses:
SELECT Phone, Email
FROM Customers;

-- To get Unique values use distinct
-- DISTINCT Queries
-- Find all unique product categories:
SELECT DISTINCT Category
FROM Products;

-- List all unique customer email addresses:
SELECT DISTINCT Email
FROM Customers;

-- Retrieve all distinct statuses from the Orders table:
SELECT DISTINCT Status
FROM Orders;



-- DDL - Data Definition Language 

-- ---------------------------------------1. CREATE – Creates New Objects-------------------------------------------------------
-- CREATE Queries

-- Create a new table for storing product reviews:
CREATE TABLE ProductReviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    ReviewText TEXT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
-- Create a new table to store product categories:
CREATE TABLE ProductCategories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE NOT NULL
);
-- Create a new table for storing shipping information:
CREATE TABLE ShippingInfo (
    ShippingID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ShippingAddress TEXT,
    ShippingDate TIMESTAMP,
    DeliveryDate TIMESTAMP,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
-- Create a new table to log user activity:
CREATE TABLE UserActivity (
    ActivityID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    ActivityType VARCHAR(50),
    ActivityDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- ------------------------------------------------- ALTER Queries-----------------------------------------------------------------
-- Add a new column Discount to the Products table:
ALTER TABLE Products
ADD Discount DECIMAL(5, 2) DEFAULT 0.00;

-- Change the data type of Phone column in Customers table to VARCHAR(30):
ALTER TABLE Customers
MODIFY Phone VARCHAR(30);    ------ it will not work in online lite mode
 
 

-- Rename the Description column in the Products table to ProductDescription:
ALTER TABLE Products
RENAME COLUMN Description TO ProductDescription;

-- Set the default value of StockQuantity in the Products table to 10:
ALTER TABLE Products
ALTER COLUMN StockQuantity SET DEFAULT 10; --- This will also not work in online mode
 

-- ---------------------------------------------------DROP Queries---------------------------------------------------------------
-- Drop the ProductReviews table:
DROP TABLE ProductReviews;

-- Drop the ShippingInfo table:
DROP TABLE ShippingInfo;

-- Drop the ProductCategories table:
DROP TABLE ProductCategories;

-- Drop the UserActivity table:
DROP TABLE UserActivity;

-- ----------------------------------------------------- TRUNCATE Queries---------------------------------------------------
-- Truncate the OrderItems table (removes all rows but keeps the table structure):
TRUNCATE TABLE OrderItems;
 
 
-- While using Mysql workbench, if the tables are dependent then remove the connection first
-- SET foreign_key_checks = 0; To diasable 
-- SET foreign_key_checks = 1; -- to add back

-- Truncate the Orders table:
TRUNCATE TABLE Orders; --- for mysql -- it will trow error cause it is dependent

SET foreign_key_checks = 0;-- first run this then trcuncate 
-- and then again run this to build connection
SET foreign_key_checks = 1;


--  --------------------------------------------RENAME Queries---------------------------------------
-- Rename the Products table to ProductCatalog:
ALTER TABLE Products
RENAME TO ProductCatalog;

RENAME TABLE ProductCatalog to Products; -- Without giving alter comamnd
 
-- Rename the OrderItems table to OrderDetails:
RENAME TABLE OrderItems TO OrderDetails;

-- Rename the Customers table to Clients:
RENAME TABLE Customers TO Clients;

-- Rename the Orders table to CustomerOrders:
RENAME TABLE Orders TO CustomerOrders;



-- DML - Data Manipulation Language 

-- ------------------------------------------- UPDATE Examples----------------------------------------------
-- Update a customer’s phone number:
UPDATE Customers
SET Phone = '555-9999'
WHERE CustomerID = 1;

-- Change the status of an order to 'Delivered':
UPDATE Orders
SET Status = 'Delivered'
WHERE OrderID = 2;

-- ----------------------------------------INSERT Examples-------------------------------------------------------------------
-- Insert a new customer into the Customers table:
INSERT INTO Customers (FirstName, LastName, Email, Phone, RegistrationDate)
VALUES ('Alice', 'Johnson', 'alice.johnson@example.com', '555-2020', '2024-08-30');

-- Add a new product to the Products table:
INSERT INTO Products (ProductName, Description, Price, StockQuantity, Category)
VALUES ('Wireless Mouse', 'Ergonomic wireless mouse with adjustable DPI', 29.99, 150, 'Accessories');

-- Insert a new order into the Orders table:
INSERT INTO Orders (CustomerID, OrderDate, Status)
VALUES (3, '2024-08-30', 'Pending');

-- -----------------------------------------------DELETE Examples-----------------------------------------------------------------
-- Delete a specific customer from the Customers table:
DELETE FROM Customers
WHERE CustomerID = 5;

-- Remove all products in the 'Furniture' category:
DELETE FROM Products
WHERE Category = 'Furniture'; -- throw error so againdiabsle the relation

-- Disable foreign key checks
SET foreign_key_checks = 0;

-- Perform the delete operation
-- and then 
-- Re-enable foreign key checks
SET foreign_key_checks = 1;





-- Delete all orders with the status 'Cancelled':
DELETE FROM Orders
WHERE Status = 'Cancelled'; -- Do the same disbale and then enable, SET foreign_key_checks = 0; SET foreign_key_checks = 1;



-- DCL - Data Control Language 

-- ----------------------------- 1. GRANT – Give Users Access: -------------------------------------------
-- To allow a user named user1 to have read and write access to both Departments and Employees tables, you can use:

-- Grant SELECT, INSERT, UPDATE, DELETE permissions on Departments table
GRANT SELECT, INSERT, UPDATE, DELETE ON Departments TO 'user1'@'localhost';

-- Grant SELECT, INSERT, UPDATE, DELETE permissions on Employees table
GRANT SELECT, INSERT, UPDATE, DELETE ON Employees TO 'user1'@'localhost';




-- -------------------------------------------------------2.REVOKE:---------------------------------------------------------
--  Withdraw User Access, Removes previously granted access rights from users or roles.
-- Revoke INSERT and DELETE permissions on Departments table
REVOKE INSERT, DELETE ON Departments FROM 'user1'@'localhost';


-- Revoke UPDATE permission on Employees table
REVOKE UPDATE ON Employees FROM 'user1'@'localhost';



-- TCL - Transaction Control Language 

-- -----------------Fisrt simple transcation with commit----------------------------------------------------------------------
-- Start a new transaction
START TRANSACTION;

-- Perform some update operations
UPDATE Products
SET Price = 1539
WHERE Category = 'Electronics';

-- Check the updated data (optional, for verification)
SELECT * FROM Products WHERE Category = 'Electronics';

-- Commit the transaction to save changes
COMMIT;

 -- -----------------Fisrt simple transcation with Rollback -------------------------------------------------------
 
 
 START TRANSACTION;

-- Perform some update operations
UPDATE Products
SET Price = 1555
WHERE Category = 'Electronics';

-- Check the updated data (optional, for verification)
SELECT * FROM Products WHERE Category = 'Electronics';

-- Commit the transaction to save changes
rollback;

-- ------------------------------- With SavePoint--------------------------------------------------

-- 1. Start a new transaction
START TRANSACTION;

-- 2. Perform some initial update operation
UPDATE Products
SET Price = 1512
WHERE Category = 'Electronics';

SELECT * FROM Products WHERE Category = 'Electronics';
-- 3. Create a savepoint after the initial update
SAVEPOINT SV1;


-- 4. Perform another update operation
UPDATE Products
SET Price = 1234
WHERE Category = 'Accessories';

SELECT * FROM Products WHERE Category = 'Accessories';



-- if we done with it we can COMMIT and if we want to change then we can rollback to savepoint 

--  Rollback to the first savepoint (undo changes made after this point)
ROLLBACK TO SAVEPOINT SV1 ;

-- 7. Commit the transaction to save the changes up to the first savepoint
COMMIT;

-- Note: The rollback operation undoes changes made after the first savepoint.
-- Therefore, only the changes made before `after_initial_update` will be visible after the commit.




-- ------------------------------------------- Aliases in SQL: ----------------------------------------------------

-- 1. Column Alias
-- Example: Rename ProductName to Name and Price to Cost.
SELECT ProductName AS Name, Price AS Cost
FROM Products;

-- 2. Table Alias
-- Example: Shorten Products to P.
SELECT P.ProductName, P.Price
FROM Products AS P;


-- --------------------------------------------------------- WHERE Clause--------------------------------------------------------
-- 1. Questions Using WHERE Clause
-- 1.	Question: Find all customers with the last name 'Smith'.
SELECT * FROM Customers
WHERE LastName = 'Smith';

-- 2.	Question: List all orders that have a status of 'Shipped'.
SELECT * FROM Orders
WHERE Status = 'Shipped';

-- 3.	Question: Find all order items with a quantity greater than 1.
SELECT * FROM OrderItems
WHERE Quantity > 1;

-- 4.	Question: List all customers who registered in August 2024.
SELECT * FROM Customers
WHERE RegistrationDate BETWEEN '2024-08-01' AND '2024-08-31';



-- -------------------------------------------------- GROUP BY Clause ------------------------------------------------------------
-- 2. Questions Using GROUP BY Clause
-- 1.	Question: Count the number of orders placed by each customer.
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID;

-- Count the number of orders per status
SELECT Status, COUNT(*) AS OrderCount
FROM Orders
GROUP BY Status;

-- 2.	Question: Find the total quantity of each product ordered.
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM OrderItems
GROUP BY ProductID;

-- 3.	Question: Get the average price of products by category.
SELECT Category, AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

-- 4.	Question: Count the number of items in each order.
SELECT OrderID, COUNT(*) AS ItemCount
FROM OrderItems
GROUP BY OrderID;


-- --------------------------------------------------HAVING Clause----------------------------------------------------
-- 3. Questions Using HAVING Clause
-- 1.	Question: Find categories where the average price of products is above $200.
SELECT Category, AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category
HAVING AVG(Price) < 200;

-- 2.	Question: Show customers who have placed more than one order.
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 1;



-- ----------------------------------- HAVING VS WHERE ---------------------------------------------------------------
-- The `WHERE` clause filters rows before grouping, 
-- while the `HAVING` clause filters groups after aggregation.

-- WHERE-----
-- To retrieve all orders placed by the customer with CustomerID 1:
SELECT * 
FROM Orders
WHERE CustomerID = 1;

-- To filter orders that were placed in August 2024:
SELECT * 
FROM Orders
WHERE YEAR(OrderDate) = 2024 AND MONTH(OrderDate) = 8;

-- Having------
-- Find Categories Where the Total Stock Quantity of Products Is Greater Than 100
SELECT Category, SUM(StockQuantity) AS TotalStock
FROM Products
GROUP BY Category
Where SUM(StockQuantity) < 100; -- it will not run

SELECT Category, SUM(StockQuantity) AS TotalStock
FROM Products
GROUP BY Category
HAVING SUM(StockQuantity) < 100;

-- MIX
-- WHERE is used to filter rows before any grouping is done.
-- HAVING is used to filter groups or aggregates after grouping
-- WHERE filters individual records, while HAVING filters the results after they are grouped by salesperson.;
SELECT Salesperson, SUM(SalesAmount) AS TotalSales
FROM Sales
WHERE SalesAmount > 100      -- Filter individual sales
GROUP BY Salesperson
HAVING SUM(SalesAmount) > 500;  -- Filter groups after aggregation



-- Find Product Categories with a Total Stock Quantity Greater Than 20, but Only for Products Priced Above $100
Select * from products;

SELECT Category, SUM(StockQuantity) AS TotalStock
FROM Products
GROUP BY Category;

SELECT Category, SUM(StockQuantity) AS TotalStock
FROM Products
WHERE Price > 100
GROUP BY Category
HAVING SUM(StockQuantity) > 20;


-- ---------------------------------------------------  ORDER BY Clause---------------------------------------------------------
-- 4. Questions Using ORDER BY Clause
-- 1.	Question: List all customers ordered by their last name.
SELECT * FROM Customers
ORDER BY LastName; -- ASC

SELECT * FROM Customers
ORDER BY LastName DesC; -- DSC

-- 2.	Question: Get products ordered by price in descending order.
SELECT * FROM Products
ORDER BY Price DESC;

-- 2. List Products by Stock Quantity and Category
-- Question: Retrieve all products ordered by stock quantity in ascending order, 
-- and within the same stock quantity, order them by category in alphabetical order.
SELECT * FROM Products
ORDER BY StockQuantity ASC, Category ASC;

SELECT * FROM Products
ORDER BY StockQuantity DESC, Category ASC;




-- --------------------------------------------------------LIMIT Clause -------------------------------------------------------
-- 1. Examples Using LIMIT Clause
-- The LIMIT clause is used to specify the number of rows to return from the result set.
-- Example 1: Retrieve the first 3 products
SELECT * FROM Products
LIMIT 3;
-- Explanation: This query will return the first 3 rows from the Products table based on the default sorting (if any).

-- Example 2: Get the top 2 most expensive products
SELECT * FROM Products
ORDER BY Price DESC
LIMIT 2;

SELECT * FROM Products
ORDER BY Price ASC -- for bottom
LIMIT 2;
-- Explanation: This query first sorts the products by price in descending order and then limits the result to the top 2 most expensive products.
-- For least expensive, use order by ASC

-- Example 3: Fetch the first 5 orders placed
SELECT * FROM Orders
ORDER BY OrderDate
LIMIT 5;
-- Explanation: This query retrieves the first 5 orders based on the order date in ascending order, 
-- showing the earliest orders first.

-- Explanation: This query retrieves the 3 most recent orders. 
-- By sorting the orders in descending order and limiting the result, it effectively shows the latest orders.



 -- ---------------------- OFFSET Clause------------------------------------------------------------------------
-- In MySQL, you cannot use the OFFSET clause by itself. 
 -- It must be used together with the LIMIT clause. 
 -- The OFFSET clause is intended to work with LIMIT to skip a specified number of rows before starting to return rows.
-- 2. Examples Using OFFSET Clause
-- The OFFSET clause is used to skip a specific number of rows before starting to return rows from the result set.

-- Example 1: Skip the first 2 products and get the next 3
SELECT * FROM Products
LIMIT 3 OFFSET 2;
-- Explanation: This query skips the first 2 products and then returns the next 3 products from the Products table.

-- Example 2: Retrieve products starting from the 5th row
SELECT * FROM Products
OFFSET 4; -- on3y offset will not work in mysql

SELECT * FROM Products
LIMIT 18446 OFFSET 4;

-- OFFSET 4: This skips the first 4 rows, so the result starts from the 5th row.
-- LIMIT 18446744073709551615: This is a very large number, effectively ensuring that all rows after the offset are included.
-- This is a MySQL-specific approach to avoid specifying an exact row count if you want all subsequent rows.

-- Example 3: Get the 4th and 5th most expensive products
SELECT 
    *
FROM
    Products
ORDER BY Price DESC
LIMIT 2 OFFSET 3;

-- Explanation: This query retrieves the 4th and 5th most expensive products. 
-- It sorts products by price in descending order, skips the top 3 most expensive products, 
-- and then limits the result to the next 2 products.  






-- --------------------------------------------------- Comparison operators --------------------------------------------------

-- Comparison operators are used to compare two values and return a Boolean result. 
-- Here are examples of how to use various comparison operators with your tables:

-- Comparison Operators Examples
-- 1. = (Equal To)
-- Example: Find all customers with the first name 'John'.

SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE FirstName = 'John';

-- Example: Retrieve all products with a price exactly equal to $299.99.
SELECT ProductID, ProductName, Price
FROM Products
WHERE Price = 299.99;

-- 2. <> (Not Equal To) or !=
-- Example: Find all orders with a status that is not 'Delivered'.
SELECT OrderID, Status
FROM Orders
WHERE Status <> 'Delivered';

SELECT OrderID, Status
FROM Orders
WHERE Status != 'Delivered';

-- Example: Get all products where the category is not 'Electronics'.
SELECT ProductID, ProductName, Category
FROM Products
WHERE Category != 'Electronics';

-- 3. > (Greater Than)
-- Example: List all customers with a registration date after '2024-09-01'.
SELECT CustomerID, FirstName, LastName, RegistrationDate
FROM Customers
WHERE RegistrationDate > '2024-09-01';

-- Example: Find all products with a price greater than $150.
SELECT ProductID, ProductName, Price
FROM Products
WHERE Price > 150;

-- 4. < (Less Than)
-- Example: Find all orders placed before '2024-08-15'.
SELECT OrderID, OrderDate
FROM Orders
WHERE OrderDate < '2024-08-15';

-- Example: Retrieve all products with stock quantity less than 30.
SELECT ProductID, ProductName, StockQuantity
FROM Products
WHERE StockQuantity < 30;


-- 5. >= (Greater Than or Equal To)
-- Example: Get all customers who registered on or after '2024-09-01'.
SELECT CustomerID, FirstName, LastName, RegistrationDate
FROM Customers
WHERE RegistrationDate >= '2024-09-01';

-- Example: Find all products with a price of $89.99 or more.
SELECT ProductID, ProductName, Price
FROM Products
WHERE Price >= 89.99;

-- 6. <= (Less Than or Equal To)
-- Example: Find all orders with an order date on or before '2024-08-25'.
SELECT OrderID, OrderDate
FROM Orders
WHERE OrderDate <= '2024-08-25';

-- Example: Retrieve all products with a stock quantity of 20 or less.
SELECT ProductID, ProductName, StockQuantity
FROM Products
WHERE StockQuantity <= 20;



-- ---------------------------------------------Logical Operator-----------------------------------------------
-- ------------------------------------------ ### **1. `AND` Operator**------------------------------------------

-- **Description:** Returns True if both conditions are True.

-- **Example 1:** Find all customers who have a phone number and were registered in September 2024.
SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE RegistrationDate BETWEEN '2024-09-01' AND '2024-09-30';

SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE Phone IS NOT NULL AND RegistrationDate BETWEEN '2024-09-01' AND '2024-09-30';

-- **Example 2:** Retrieve products that are in the 'Furniture' category and have a stock quantity greater than 20.
SELECT ProductID, ProductName, StockQuantity
FROM Products
WHERE Category = 'Furniture' AND StockQuantity > 20;


-- ----------------------------------### **2. `OR` Operator**--------------------------------------------------------------------

-- **Description:** Returns True if at least one of the conditions is True.

-- **Example 1:** Find all orders that are either 'Shipped' or 'Delivered'.
SELECT OrderID, Status
FROM Orders
WHERE Status = 'Shipped' OR Status = 'Delivered';


-- **Example 2:** Get all products that are either in the 'Electronics' category or have a price less than $100.
SELECT ProductID, ProductName, Price
FROM Products
WHERE Category = 'Electronics' OR Price < 100;

-- ---------------------------------## **3. `NOT` Operator**----------------------------------------------------------------

-- **Description:** Reverses the result of a Boolean condition.

-- **Example 1:** Find all products that are not in the 'Accessories' category.
SELECT ProductID, ProductName, Category
FROM Products
WHERE NOT Category = 'Accessories';

SELECT ProductID, ProductName, Category
FROM Products
WHERE Category <> 'Accessories';



-- **Example 2:** Get all customers who do not have a phone number listed.
SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE Phone IS NULL;


-- -------------------------------------------### **4. `IN` Operator**-------------------------------------------------------------

-- **Description:** Returns True if a value matches any value in a set of values.

-- **Example 1:** Find all orders where the order ID is either 1, 3, or 5.
SELECT OrderID, Status
FROM Orders
WHERE OrderID IN (1, 3, 5, 123);


-- **Example 2:** Get all products that belong to either the 'Electronics' or 'Furniture' categories.
SELECT ProductID, ProductName, Category
FROM Products
WHERE Category IN ('Electronics', 'Furniture');


-- ------------------------------------## **5. `BETWEEN` Operator**-----------------------------------------------------------

-- **Description:** Returns True if a value falls within a specific range.

-- **Example 1:** Find all orders placed between '2024-08-15' and '2024-08-25'.
SELECT OrderID, OrderDate
FROM Orders
WHERE OrderDate BETWEEN '2024-08-15' AND '2024-08-25';


-- **Example 2:** Get all products with a price between $100 and $300.
SELECT ProductID, ProductName, Price
FROM Products
WHERE Price BETWEEN 100 AND 300;


-- ----------------------------------### **6. `LIKE` Operator**---------------------------------------------------------

-- **Description:** Returns True if a value matches a specified pattern.

-- **Example 1:** Find all customers whose last name starts with 'S'.
SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE LastName LIKE 'S%';

-- Find all customers whose last name ends with 'n'.
SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE firstName LIKE '%E';



-- **Example 2:** Get all products with 'Desk' in their description.
SELECT ProductID, ProductName, Description
FROM Products
WHERE Description LIKE '%able%';




-- --------------------------------------- Join In Next Chapter---------------------------------------------------------------------
