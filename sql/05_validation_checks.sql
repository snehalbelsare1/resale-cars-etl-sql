/* 
-- Project: Resale Cars ETL
-- File: 05_Validation_checks.sql
-- Purpose: Performs data quality and reconciliation checks to ensure ETL accuracy.
-- Database: SQL Server
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
		05. DATA VALIDATITION CHECKS
   --------------------------------------------------------------------------
   -------------------------------------------------------------------------- */

	-- i. Record Match
		SELECT COUNT (*) FROM Cars_stg;			-- Cars_stg confirms 500 rows
		SELECT COUNT (*) FROM Customers_stg;	-- Customers_stg confirms 2000 rows
		SELECT COUNT (*) FROM fact_sales;		-- fact_sales confirms 10,000 rows

	-- ii. Referential Integrity Check
		-- For Car_Id
			SELECT COUNT (*)
			FROM fact_sales f
			LEFT JOIN dim_cars c ON f.Car_Id = c.Car_Id
			WHERE c.Car_Id IS NULL;
		-- For Customer_Id
			SELECT COUNT (*)
			FROM fact_sales f
			LEFT JOIN dim_customers cu ON f.Customers_Id = cu.Customer_Id
			WHERE cu.Customer_Id IS NULL;		-- Result is '0' (Expected)

	--iii. Negative / Invalid Value Check
		SELECT *
		FROM fact_sales
		WHERE Quantity <= 0 OR Sale_Price <=0;	-- No negative/invalid values.

	-- iv. Date Sanity Check
		SELECT *
		FROM fact_sales
		WHERE Sale_Date > GETDATE ();			-- Validated

	--v. Revenue Validation
		SELECT SUM (Quantity * Sale_Price) AS Staging_Revenue 
		FROM Sales_stg;							-- Staging revenue: 1,146,524,572.39
		SELECT SUM (Total_Amount) AS Fact_Revenue
		FROM fact_sales;						-- Fact revenue: 1,146,524,572.39
