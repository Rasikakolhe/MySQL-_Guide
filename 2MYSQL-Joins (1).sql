
                          -- ------------------------JOINS--------------------

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Insert data into Employees Table
INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID, Salary) VALUES 
(1, 'John Doe', 101, 60000.00),
(2, 'Jane Smith', 102, 75000.00),
(3, 'Alice Johnson', NULL, 50000.00), -- No department assigned
(4, 'Bob Brown', 103, 45000.00),
(5, 'Michael Lee', 104, 85000.00),
(6, 'Emily Davis', 105, NULL); -- No salary assigned

-- Insert data into Departments Table
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES 
(101, 'HR'),
(102, 'Finance'),
(103, 'Engineering'),
(104, 'Marketing'),
(106, 'Sales'); -- No matching employees



-- Examples for each SQL operation, including different types of joins 
-- (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN`) 
-- and set operations (`UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT`). 
-- These examples will demonstrate how the operations work with the `Employees` and `Departments` tables.

											### 1. Examples of Different Types of Joins

-- ---------------------------------------------------- **1.1 INNER JOIN Examples**-------------------------------------------------------------
-- 1. **Example 1: Basic INNER JOIN** Inner Join and SImple JOins are Same as explain in the concept sheet by Me
   -- Retrieves employees with matching departments.
   
   SELECT E.EmployeeID, E.EmployeeName, D.DepartmentName
   FROM Employees E
   INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;
  
     SELECT E.EmployeeID, E.EmployeeName, D.DepartmentName
   FROM Employees E
   INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;
   
   -- **Output:** Only shows employees who have a corresponding department.

-- 2. **Example 2: INNER JOIN with Salary Filter**
   -- Retrieves employees with matching departments and salary greater than `50,000`.
   
   SELECT E.EmployeeID, E.EmployeeName, D.DepartmentName, E.salary
   FROM Employees E
   INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
   WHERE E.Salary > 50000;
   
   --  **Output:** Only employees with a department and salary above `50,000` are shown.
   
   
   

-- ------------------------------------------------- #### **1.2 LEFT JOIN Examples**---------------------------------------------------
-- 1. **Example 1: Basic LEFT JOIN**
  -- Retrieves all employees, including those without a department.
   
   SELECT E.EmployeeID, E.EmployeeName, D.DepartmentName
   FROM Employees E
   LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;
   
   -- **Output:** Shows all employees, with `NULL` for those without a matching department.

-- 2. **Example 2: LEFT JOIN with Missing Departments**
   -- Retrieves employees without a department.
   
   SELECT E.EmployeeID, E.EmployeeName, D.DepartmentID
   FROM Employees E
   LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID
   WHERE D.DepartmentID IS NULL;
   
   -- **Output:** Shows employees with no assigned department (`DepartmentID` is `NULL`).



-- -------------------------------------------------- #### **1.3 RIGHT JOIN Examples------------------------------------------------------
-- 1. **Example 1: Basic RIGHT JOIN**
   -- Retrieves all departments, including those without any employees.
   
   SELECT E.EmployeeID, E.EmployeeName, D.DepartmentName
   FROM Employees E
   RIGHT JOIN Departments D ON E.DepartmentID = D.DepartmentID;
   
   -- **Output:** Shows all departments, with `NULL` for departments with no employees.

-- 2. **Example 2: RIGHT JOIN with Employees Count**
   -- Retrieves all departments and the number of employees in each department.
   
   SELECT D.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount
   FROM Employees E
   RIGHT JOIN Departments D ON E.DepartmentID = D.DepartmentID
   GROUP BY D.DepartmentName;
   
   -- **Output:** Lists each department and how many employees belong to it (departments with no employees will have `0`).
   
   

-- ------------------------------------------- #### **1.4 FULL JOIN Examples** ---------------------------------------------------
-- (MySQL does not support `FULL JOIN` directly; we can simulate it using `UNION`.)
-- Basic Syntax for FULL JOIN in SQL Server, PostgreSQL, Oracle:
SELECT 
    A.Column1, A.Column2, B.Column1, B.Column2
FROM 
    TableA A
FULL OUTER JOIN 
    TableB B 
ON 
    A.CommonColumn = B.CommonColumn;
    
    
-- 1. **Example 1: Emulated FULL JOIN**
   -- Retrieves all employees and all departments, combining both left and right joins.
   
   SELECT E.EmployeeID, E.EmployeeName, D.DepartmentName
   FROM Employees E
   LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID
   UNION
   SELECT E.EmployeeID, E.EmployeeName, D.DepartmentName
   FROM Employees E
   RIGHT JOIN Departments D ON E.DepartmentID = D.DepartmentID;
   
   -- **Output:** Lists all employees and all departments, with `NULL` values where there are no matches.
   
   
   
   
   
   --  ----------------- Self Join---------
   
   
-- What is a Self Join? A Self Join is a regular join where a table is joined with itself. This is useful when you want to compare rows within the same table or find relationships within the same table.

-- Why Use Self Join?
--  To find relationships within the same table (like employees reporting to other employees).

-- To compare rows within a table.
-- Example: Employee Table
-- Let's say you have an employees table where each employee has a manager_id that refers to another employee within the same table.
   
   
   -- Self-Relationship: Helps in cases where entities within the same table relate to each other, such as parent-child relationships in a table.
  
  drop database db99;
create database db99;
use db99;

   CREATE TABLE employees99 (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);




INSERT INTO employees99 (id, name, manager_id)
VALUES
(1, 'John', NULL),
(2, 'Sarah', 1),
(3, 'Mike', 1),
(4, 'Jessica', 2),
(5, 'David', 2);


-- Get the following
-- Employee: The name of each employee.
-- Manager: The name of the manager for each employee.
Select * from Employees99;

SELECT e1.name AS Employee, e1.id as ID, e2.name AS Manager
FROM employees99 e1
LEFT JOIN employees99 e2
ON e1.manager_id = e2.id;
-- This query joins the employees table with itself:

/*
e1 is the alias for the employee.
e2 is the alias for the manager.
The ON clause matches employees (e1.manager_id) with their managers (e2.id).

*/



-- ------------------------------------ Cross JOIN ------------------------------------

#### 1. **Create Tables**

-- First, create two simple tables, `employees` and `departments`.

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

#### 2. **Insert Data**

INSERT INTO employees (id, name) 
VALUES 
(1, 'Alice'), 
(2, 'Bob'),
(3, 'blue'),
(4, 'Nob');


INSERT INTO departments (dept_id, dept_name) 
VALUES 
(101, 'HR'), 
(102, 'HR1'), 
(103, 'HR2'), 
(104, 'Sales');


#### 3. **Definition and Concept**

-- A `CROSS JOIN` combines all rows from the `employees` table with all rows from the `departments` table. I
-- t returns a **Cartesian product**, meaning all possible combinations of rows between the two tables.

/*
In real work, you use `CROSS JOIN` to get **all possible combinations** of rows between two tables. It’s helpful for:

1. **Testing combinations** (e.g., products with discounts).
2. **Generating reports** where every relationship between two datasets is needed.
3. **Simulations** where every possible pairing is analyzed.

It's rare because it can create large result sets but is useful for specific scenarios like testing or reporting combinations.
*/
#### 4. **Syntax of `CROSS JOIN`**

SELECT employees.name, departments.dept_name
FROM employees
CROSS JOIN departments;



#### 5. **Example with Explanation**


SELECT employees.name, departments.dept_name
FROM employees
CROSS JOIN departments;



-- **Explanation:**
-- Every employee is paired with every department (HR and Sales).
-- No condition is required; the query simply generates all combinations. 



