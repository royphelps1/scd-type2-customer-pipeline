-- ================================================
-- 🔁 Reset & Rebuild History Table (With Identity)
-- File: 05_reset_and_rebuild_history.sql
-- Author: Roy Phelps
-- Description:
--   - Renames the old Customer_History_WithID table
--   - Recreates the table with an IDENTITY-based surrogate key
--   - Migrates old historical data (excluding old primary key)
--   - Verifies structure with SELECT
-- ================================================


-- STEP 1: Rename the existing table to preserve it (just in case)
IF OBJECT_ID('dbo.Customer_History_WithID_old') IS NOT NULL
    DROP TABLE dbo.Customer_History_WithID_old;

EXEC sp_rename 'dbo.Customer_History_WithID', 'Customer_History_WithID_old';

-- STEP 2: Recreate the table with proper IDENTITY on HistoryID
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

-- STEP 3: Migrate existing rows WITHOUT including HistoryID
INSERT INTO dbo.Customer_History_WithID (
    CustomerID, Name, City, Balance, StartDate, EndDate, IsCurrent
)
SELECT
    CustomerID, Name, City, Balance, StartDate, EndDate, IsCurrent
FROM dbo.Customer_History_WithID_old;

-- STEP 4: Verify it's clean
SELECT * FROM dbo.Customer_History_WithID ORDER BY CustomerID, StartDate;
