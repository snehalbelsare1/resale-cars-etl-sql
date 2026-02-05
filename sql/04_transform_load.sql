/* 
-- Project: Resale Cars ETL
-- File: 04_Transform_load.sql
-- Purpose: Transforms and loads validated data from staging into dimension and fact tables.
-- Database: SQL Server
--------------------------------------------------------------------------
   --------------------------------------------------------------------------
		04. TRANSFORM LOAD
   --------------------------------------------------------------------------
   -------------------------------------------------------------------------- */

	--i. dim_cars Table
		INSERT INTO dim_cars
		SELECT DISTINCT
		Car_Id,Make,Model,Year,Color,Engine_Type,Transmission,Price,Quantity_In_Stock,Status
		FROM Cars_stg
		WHERE Car_Id IS NOT NULL;
		-- Identify affected records
			SELECT Car_Id,Make,Model
			FROM dim_cars
			WHERE Make IS NULL;						-- C0015,C0033,C0086,C0330
		-- Enrich Make Values
			UPDATE dim_cars
			SET Make = 'Nissan'
			WHERE Model = 'Altima' AND Make IS NULL;
			UPDATE dim_cars
			SET Make = 'Tesla'
			WHERE Model = 'Model 3' AND Make IS NULL;
			UPDATE dim_cars
			SET Make = 'Hyundai'
			WHERE Model = 'Tucson' AND Make IS NULL;
			UPDATE dim_cars
			SET Make = 'BMW'
			WHERE Model = '5 Series' AND Make IS NULL;
		-- Validation
			SELECT COUNT(*) 
			FROM dim_cars
			WHERE Make IS NULL;						-- No missing values.
	--ii. dim_customers Table
		INSERT INTO dim_customers
		SELECT DISTINCT
		Customer_Id,First_Name,Last_Name,Gender,Age,Job_Title,Phone_Number,Email,City,State,Region
		FROM Customers_stg
		WHERE Customer_Id IS NOT NULL;
	--iii. fact_sales table
		INSERT INTO fact_sales (
		Sales_Id,Sale_Date,Car_Id,Customers_Id,Quantity,Sale_Price,Payment_Method,Salesperson
		)
		SELECT 
			s.Sale_Id,
			s.Sale_Date,
			s.Car_Id,
			s.Customer_Id,
			s.Quantity,
			s.Sale_Price,
			s.Payment_Method,
			s.Salesperson
		FROM Sales_stg s
		JOIN dim_cars c ON s.Car_Id = c.Car_Id
		JOIN dim_customers cu ON s.Customer_Id = cu.Customer_Id
		WHERE s.Sale_Price IS NOT NULL;				
