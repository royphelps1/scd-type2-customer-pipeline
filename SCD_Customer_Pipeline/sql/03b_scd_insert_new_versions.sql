-- ================================================
-- 🔄 SCD Type 2 - Insert New Versions
-- File: 03b_scd_insert_new_versions.sql
-- Author: Roy Phelps
-- Description:
--   - Looks for recently updated (closed) history rows
--   - Inserts a new version for each changed customer
--   - Uses LastUpdated as StartDate
--   - Sets IsCurrent = 1 and EndDate = NULL
-- ================================================


-- STEP 2: Re-insert new records using the updated history
WITH JustUpdated AS (
    SELECT *
    FROM dbo.Customer_History_WithID
    WHERE IsCurrent = 0 AND EndDate = '2024-10-01 08:00:00.0000000'
)
INSERT INTO dbo.Customer_History_WithID (
    CustomerID, Name, City, Balance, StartDate, EndDate, IsCurrent
)
SELECT
    S.CustomerID,
    S.Name,
    S.City,
    S.Balance,
    S.LastUpdated AS StartDate,
    NULL AS EndDate,
    1 AS IsCurrent
FROM dbo.Customer_Staging S
JOIN JustUpdated H
  ON S.CustomerID = H.CustomerID
WHERE 
    H.Name <> S.Name OR
    H.City <> S.City OR
    H.Balance <> S.Balance;
