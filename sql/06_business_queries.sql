/* 
-- Project: Resale Cars ETL
-- File: 06_Business_queries.sql
-- Purpose: Generates analytical queries to answer key business questions and support reporting.
-- Database: SQL Server
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
		06. BUSINESS REPORT QUERIES
   --------------------------------------------------------------------------
   -------------------------------------------------------------------------- */

	-- i. KPI 
		SELECT
			AVG (Total_Amount) AS Avg_Order_Value
		FROM fact_sales;						-- Avg_Order_Value is $114,652.45
	
	-- ii. Top Selling Cars
		SELECT
			c.Make,
			c.Model,
			SUM (f.Quantity) AS Unit_Sold,
			SUM (f.Total_Amount) AS Revenue
		FROM fact_sales f
		JOIN dim_cars c ON f.Car_Id = c.Car_Id
		GROUP BY c.Make, c.Model
		ORDER BY Revenue DESC;
												-- Top 3 Products : #1. Toyota - Camry, 
												--					        #2. Nissan - Sunny, 
												--					        #3. Tesla - Model X 
	-- iii. Sales By Region 
		SELECT
			cu.Region,
			SUM(f.Total_Amount) AS Total_Sales
		FROM fact_sales f
		JOIN dim_customers cu ON f.Customers_Id = cu.Customer_Id
		GROUP BY cu.Region 
		ORDER BY Total_Sales DESC;
					-- Top Contributing Region: South with total sale of $359,074,167.04.
	
	-- iv. Sales By Month
		SELECT
		 FORMAT(Sale_Date, 'yyyy-MM') AS Sales_Month,
		 SUM(Total_Amount) AS Monthly_Revenue
		FROM fact_sales
		GROUP BY FORMAT(Sale_Date, 'yyyy-MM')
		ORDER BY Sales_Month;
					-- Sales showing upward trend during new years holiday period.

		-- Business Problem Solved:
		--	This ETL pipeline enables management to analyze vehicle sales performance, regional demand, and revenue trends using a centralized star-schema warehouse. 
		--	It replaces manual CSV reporting and ensures data accuracy through validation and reconciliation.
