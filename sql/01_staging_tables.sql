/*
-- Project: Resale Cars ETL
-- File: 01_Staging_table.sql
-- Purpose: Creates staging tables to store raw data exactly as received from source CSV files.
-- Database: SQL Server
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
		01. STAGING TABLES
   --------------------------------------------------------------------------
   -------------------------------------------------------------------------- */

	--i. Cars_clean.csv (Staging table)
		CREATE TABLE Cars_stg (	
			Car_Id VARCHAR(50),
			Make VARCHAR(50),
			Model VARCHAR(50),
			Year INT,
			Color VARCHAR(50),
			Engine_Type VARCHAR(50),
			Transmission VARCHAR(50),
			Price DECIMAL(10,2),
			Quantity_In_Stock INT,
			Status VARCHAR(50)
		);								  	-- Table created sucessfully.
		
	--ii. Customers_clean.csv (Staging table)
		CREATE TABLE Customers_stg (
			Customer_Id VARCHAR(50),
			First_Name VARCHAR(50),
			Last_Name VARCHAR(50),
			Gender VARCHAR(50),
			Age INT,
			Job_Title VARCHAR(50),
			Phone_Number VARCHAR(50),
			Email VARCHAR(50),
			City VARCHAR(50),
			State VARCHAR(50),
			Region VARCHAR(50)
			);								-- Table created successfully.

	--iii. Sales_clean.csv (Staging table)
		CREATE TABLE Sales_stg (
			Sale_Id  VARCHAR(50),
			Customer_Id VARCHAR(50),
			Car_Id VARCHAR(50),
			Sale_Date Date,
			Quantity INT,
			Sale_Price DeCIMAL(10,2),
			Payment_Method VARCHAR(50),
			Salesperson VARCHAR(50)
		);									-- Table created successfully.
	
	--DATA PROFILING 
		--i. Check Record Counts 
			SELECT COUNT (*) FROM Cars_stg;			-- 500
			SELECT COUNT (*) FROM Customers_stg;	-- 2000
			SELECT COUNT (*) FROM Sales_stg;		-- 10000
		--ii. Check Duplicates
			-- For Car_stg 
				SELECT Car_Id, COUNT (*)
				FROM Cars_stg
				GROUP BY Car_Id 
				HAVING COUNT (*) > 1;
			-- For Customers_stg
				SELECT Customer_Id, COUNT (*)
				FROM Customers_stg
				GROUP BY Customer_Id
				HAVING COUNT (*) > 1;
			-- For Sales_stg
				SELECT Sale_Id, COUNT (*)
				FROM Sales_stg
				GROUP BY Sale_Id
				HAVING COUNT (*) > 1;
				-- No duplicates and data quality issues as per performed data profiling.
