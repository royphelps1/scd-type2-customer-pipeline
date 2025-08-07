-- ================================================
-- 🏗️ Create Base Tables
-- File: 01_create_tables.sql
-- Author: Roy Phelps
-- Description:
--   - Creates staging and history tables for SCD Type 2 demo
--   - History table uses a surrogate key with IDENTITY
-- ================================================

-- Drop if they already exist (optional safety)
IF OBJECT_ID('dbo.Customer_Staging', 'U') IS NOT NULL DROP TABLE dbo.Customer_Staging;
IF OBJECT_ID('dbo.Customer_History_WithID', 'U') IS NOT NULL DROP TABLE dbo.Customer_History_WithID;

-- Create staging table (simulates daily source feed)
CREATE TABLE dbo.Customer_Staging (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Balance INT NOT NULL,
    LastUpdated DATETIME2(7) NOT NULL
);

-- Create history table with surrogate key
CREATE TABLE dbo.Customer_History_WithID (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Balance INT NOT NULL,
    StartDate DATETIME2(7) NOT NULL,
    EndDate DATETIME2(7) NULL,
    IsCurrent BIT NOT NULL
);
