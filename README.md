# 🗄️ SQL Data Warehouse Project

## 📌 Project Overview
This project demonstrates the design and implementation of a modern **SQL-based Data Warehouse** using **T-SQL** following the **Medallion Architecture (Bronze → Silver → Gold)**. The system ingests raw data from multiple sources (CRM and ERP), transforms and cleanses it using Stored Procedures, and exposes the final data via **SQL Views** optimized for Power BI and reporting.

The solution ingests raw data from CRM and ERP systems, applies structured data cleansing and transformations via Stored Procedures, and exposes analytics-ready datasets through SQL Views optimized for reporting tools like tableau/Power BI.

The architecture enforces strong data quality practices, consistent naming conventions, and a clear separation between raw ingestion and business-consumable data.

---

## 🏛️ System Architecture & Data Flow
The warehouse follows a layered design to ensure traceability, scalability, and data reliability.
<img width="1025" height="685" alt="image" src="https://github.com/user-attachments/assets/50d61a2b-eecd-4885-839a-216337894580" />

### 1. 🥉 Bronze Layer – Raw Data Storage
* **Object Type:** Tables
* **Purpose:** Persist raw data exactly as received from source systems
* **Data Model:** None ("As-is").
* **Transformations:** None
* **Load Method:** Full Load(Truncate & Insert) using Stored Procedure (Eg: `load_bronze`).
* **Source Systems:**
    * **CRM:** Customer and sales-related datasets.
    * **ERP:** Product, logistics, and category datasets.

### 2. 🥈 Silver Layer – Data Cleansing & Standardization
* **Object Type:** Tables
* **Purpose:** Improve data quality by cleaning, standardizing, and consolidating raw data from the Bronze layer.
* **Data Model:** None ("As-is")
* **Load Method:** Full Load(Truncate & Insert) using Stored Procedure (`load_silver`).
* **Transformations Applied:**
    * Removal of duplicate records.
    * Elimination of NULLs from primary keys.
    * Trimming extra whitespace (leading/trailing whitespaces).
    * Standardization of `Gender` and `Marital Status` values.
    * Handled NULL values for critical attributes.
    * Date correction and validation

### 3. 🥇 Gold Layer – Business-Ready Model
* **Object Type:** SQL Views (Virtual Layer)
* **Purpose:** Deliver business-friendly datasets using a Star Schema.
* **Data Model:**
  * Star Schema
  * Flat tables (denormalized for reporting)
  * Aggregated tables for performance optimization
* **Load Method:** Not required (Logic is encapsulated within SQL views).
* **Business Logic:**
    * Data integration from Silver tables.
    * Aggregations and calculated measures.
    * Dimensional modeling (`dim` and `fact`)
    * Business rule implementation.

---

## 🧱 Data Modeling Strategy

The warehouse follows a Star Schema model.

### Dimensions:
* Customers
* Products

### Fact Tables:
* Sales

### Benefits:
* Faster query performance
* Intuitive analytics
* BI-tool compatibility

---

## 🛠️ Naming Standards & Conventions

Consistent naming conventions are applied across the warehouse to improve readability and governance.

### General Guidelines
* **Case Style:** snake_case (`lower_case_with_underscores`).
* **Language:** English only.
* **Constraints:** Avoid SQL reserved keywords as object names.

### Table & View Naming
| Layer | Object Type | Pattern | Example | Description |
| :--- | :--- | :--- | :--- | :--- |
| **Bronze** | Table | `<source>_<entity>` | `crm_cust_info` | Mirrors source system names |
| **Silver** | Table | `<source>_<entity>` | `crm_cust_info` | Matches original source name. |
| **Gold** | View | `<category>_<entity>` | `gold.dim_customers` | Business-oriented naming|

### Column Naming
| Type | Pattern | Example | Description |
| :--- | :--- | :--- | :--- |
| **Surrogate Keys** | `<table_name>_key` | `customer_key` | Unique dimension identifiers |
| **Technical Cols** | `dwh_<column_name>` | `dwh_load_date` | System Metadata (e.g., load timestamp). |

### Stored Procedures
* **Pattern:** `load_<layer>`
* **Usage:** Only used for loading physical tables (Bronze & Silver).
* **Examples:** `load_bronze`, `load_silver`

---

## 📂 Data Sources
The project consumes CSV datasets located in the `datasets` folder:
* [📂 View Datasets](https://github.com/deekshagupta-86/sql-data-warehouse-project/tree/c6f6ad8b3e489edf3ec18b32a6c336fe11d13996/datasets)
    * `source_crm`: Contains sales and customer CSVs.
    * `source_erp`: Contains logistics and product category CSVs.

---

## 🚀 How to Execute the Project
The ETL process is managed via Stored Procedures for the physical layers, while the Gold layer is immediately queryable as Views.

**Step-1: Initialize Database:** Run the DDL scripts given in scripts folder to create:
* Database
* Bronze tables
* Silver tables
* Gold views

**Step-2: Load Bronze Layer:**
    ```sql
    EXEC load_bronze;
    ```
    *Loads raw CSV data into Bronze tables.*

**Step-3: Load Silver Layer:**
    ```sql
    EXEC load_silver;
    ```
    *Applies cleansing, validation, and standardization rules.*

**Step-4: Query Gold Layer:**
    ```sql
    SELECT * FROM gold.dim_customers;
    SELECT * FROM gold.fact_sales;
    SELECT * FROM gold.dim_products;
    ```
    
---
## 📊 Analytical Exploration
Once the Gold layer was finalized, I conducted in-depth SQL analysis to verify data accuracy and extract meaningful business insights. The analysis was structured into two phases: Exploratory Data Analysis (EDA) and advanced analytical modeling.

### 1.🔍 Exploratory Data Analysis (EDA)
Prior to performing detailed reporting and advanced queries, I carried out Exploratory Data Analysis (EDA) to examine the dataset’s structure, completeness, and overall quality.
* **Database Analysis:** Reviewed table definitions, validated record counts, and confirmed schema consistency.
* **Dimensions Analysis:** Reviewed unique values in dimension tables (`dim_customers`, `dim_products`) to validate consistency and standardization.
* **Timeline Analysis:** Verified the overall date range and analyzed the time-based distribution of sales records.
* **Metrics Anlysis:** Computed high-level metrics such as total revenue and total orders to establish baseline performance indicators.
* **Distribution Analysis:** Evaluated aggregated performance by category to understand data distribution.
* **Ranking Analysis:** Ranked entities such as customers and products based on performance metrics to identify top and bottom performers.

### 2.📈 Advanced Analytics
Applied advanced query techniques in SQL to generate data-driven business intelligence.
* **Change-Over-Time Analysis:** Examined year-over-year and month-over-month sales patterns to detect seasonal trends.
* **Cumulative Analysis:** Computed cumulative totals and moving averages to track performance trends over time.
* **Performance Analysis:** Evaluated current sales performance against historical benchmarks to measure growth and variance.
* **Part-to-Whole Analysis:** Measured the revenue contribution of each product category relative to overall sales.
* **Data Segmentation:** Classified customers and products into distinct segments to identify different market groups.
* **Customer & Product Report :** Developed consolidated summary views highlighting key business KPIs.

---

## 🧰 Technology Stack
* **SQL:** T-SQL
* **Architecture:** Medallion (Bronze / Silver / Gold)
* **Modeling:** Star Schema
* **ETL:** Stored Procedures
* **Analytics:** SQL Views

---

## 📩 Connect & Feedback
If you have any questions, suggestions, or ideas for improvement, feel free to reach out or open an issue in the repository to share your thoughts.
