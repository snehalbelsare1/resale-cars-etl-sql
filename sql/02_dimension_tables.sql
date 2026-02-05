/* 
-- Project: Resale Cars ETL
-- File: 02_Dimension_table.sql
-- Purpose: Builds cleaned and business-friendly dimension tables for cars and customers.
-- Database: SQL Server
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
		02. DIMENSION TABLES
   --------------------------------------------------------------------------
   -------------------------------------------------------------------------- */	
	--i. Cars Dimension Table
		CREATE TABLE dim_cars (
		Car_Id VARCHAR(50) PRIMARY KEY,
		Make VARCHAR(50),
		Model VARCHAR(50),
		Year INT,
		Color VARCHAR(50),
		Engine_Type VARCHAR(50),
		Transmission VARCHAR(50),
		Price DECIMAL(10,2),
		Quantity_In_Stock INT,
		Status VARCHAR(50)
		);										-- Table created successfully.
	--ii. Customers Dimension Table
		CREATE TABLE dim_customers (
		Customer_Id VARCHAR(50) PRIMARY KEY,
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
		);										-- Table created successfully.
