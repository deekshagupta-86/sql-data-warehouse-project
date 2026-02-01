/*
=============================================================================

Initialization of Database and Schemas

=============================================================================
Purpose: 


This script initializes a new database named 'DataWarehouse'.If the database already exists, 
it will be removed and recreated. After creation, three schemas are added: bronze, silver, and gold
to support a layered data warehouse architecture.

WARNING: Executing this script will permanently drop any database named "DataWarehouse" if it already present

*/

USE master;
GO

-- Check if database exists and remove it

IF EXISTS (SELECT 1 FROM sys.databases where name = 'DataWarehouse')

BEGIN 
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;

GO

-- create new database
CREATE DATABASE DataWarehouse;
Go


USE DataWarehouse;
GO

--creating schemas: bronze, silver, gold
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
