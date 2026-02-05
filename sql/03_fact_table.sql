/* 
-- Project: Resale Cars ETL
-- File: 03_Fact_table.sql
-- Purpose: Creates the fact table to store transactional sales data and calculated metrics.
-- Database: SQL Server
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
		03. Fact Table
   --------------------------------------------------------------------------
   -------------------------------------------------------------------------- */

	-- Create Table : Fact Sales
		CREATE TABLE fact_sales (
		Sales_Id  VARCHAR(50) PRIMARY KEY,
		Sale_Date Date,
		Car_Id VARCHAR(50),
		Customers_Id VARCHAR(50),
		Quantity INT,
		Sale_Price DeCIMAL(10,2),
		Total_Amount AS (Quantity * Sale_Price) PERSISTED,
		Payment_Method VARCHAR(50),
		Salesperson VARCHAR(50)
		);
		-- Records with missing Car_Id or Customer_Id are excluded via INNER JOIN during fact load
