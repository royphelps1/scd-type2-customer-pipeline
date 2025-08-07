-- ================================================
-- 🔄 SCD Type 2 - Update Existing Rows
-- File: 03a_scd_update_existing.sql
-- Author: Roy Phelps
-- Description:
--   - Finds changed records in staging vs current history
--   - Sets EndDate and IsCurrent = 0 for old versions
-- ================================================

UPDATE H
SET 
    H.EndDate = S.LastUpdated,
    H.IsCurrent = 0
FROM dbo.Customer_History_WithID H
JOIN dbo.Customer_Staging S
  ON H.CustomerID = S.CustomerID
WHERE 
    H.IsCurrent = 1
    AND (
        H.Name <> S.Name OR
        H.City <> S.City OR
        H.Balance <> S.Balance
    );
