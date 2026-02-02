/*
================================================================================
Stored Procedure to load data into Bronze Layer (Source → Bronze)
================================================================================

Purpose:
This stored procedure loads raw data from external CSV files into the `bronze`
schema.
- It truncates existing data from all Bronze tables
- Uses BULK INSERT to load data from source files(csv files) to bronze tables.

Parameters:
None

Returns:
None
It does not accept any parameters or return any values.

Execution:
EXEC bronze.load_bronze;
================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '************************************************';
		PRINT '>>Truncating table: bronze.crm_cust_info';
		PRINT '************************************************';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '************************************************';
		PRINT '>>Loading data into table: bronze.crm_cust_info';
		PRINT '************************************************';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\manoj\Desktop\Sql_project_datasets\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		PRINT '************************************************';
		PRINT '>>Truncating table: bronze.crm_prd_info';
		PRINT '************************************************';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '************************************************';
		PRINT '>>Loading data into table: bronze.crm_prd_info';
		PRINT '************************************************';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\manoj\Desktop\Sql_project_datasets\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		PRINT '************************************************';
		PRINT '>>Truncating table: bronze.crm_sales_details';
		PRINT '************************************************';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '************************************************';
		PRINT '>>Loading data into table: bronze.crm_sales_details';
		PRINT '************************************************';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\manoj\Desktop\Sql_project_datasets\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		PRINT '------------------------------------------------';
		PRINT 'Loaded CRM tables';
		PRINT '------------------------------------------------';

		PRINT '------------------------------------------------';
		PRINT 'Loading ERP tables';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '************************************************';
		PRINT '>>Truncating table: bronze.erp_cust_az12';
		PRINT '************************************************';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '************************************************';
		PRINT '>>Loading data into table: bronze.erp_cust_az12';
		PRINT '************************************************';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\manoj\Desktop\Sql_project_datasets\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		PRINT '************************************************';
		PRINT '>>Truncating table: bronze.erp_loc_a101';
		PRINT '************************************************';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT '************************************************';
		PRINT '>>Loading data into table: bronze.erp_loc_a101';
		PRINT '************************************************';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\manoj\Desktop\Sql_project_datasets\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		PRINT '************************************************';
		PRINT '>>Truncating table: bronze.erp_px_cat_g1v2';
		PRINT '************************************************';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT '************************************************';
		PRINT '>>Loading data into table: bronze.erp_px_cat_g1v2 ';
		PRINT '************************************************';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\manoj\Desktop\Sql_project_datasets\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		SET @batch_end_time = GETDATE();
		PRINT '------------------------------------------------';
		PRINT 'Loaded ERP tables';
		PRINT '------------------------------------------------';

		PRINT '================================================';
		PRINT 'Loaded Bronze layer';
		PRINT '================================================';
		PRINT '   - Total Load Duration of bronze: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
	END TRY
	BEGIN CATCH
		PRINT '================================================'
		PRINT 'ERROR OCCURED'
		PRINT 'Error Message:' + ERROR_MESSAGE();
		PRINT 'Error Message:' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT '================================================'
	END CATCH
END
