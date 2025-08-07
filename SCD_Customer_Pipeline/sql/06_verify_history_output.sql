-- ================================================
-- ✅ Verify SCD2 Output
-- File: 06_verify_history_output.sql
-- Author: Roy Phelps
-- Description:
--   - Selects all rows from Customer_History_WithID
--   - Orders by CustomerID and StartDate to display historical changes
--   - Used to verify results after update/insert logic runs
-- ================================================


SELECT * 
FROM dbo.Customer_History_WithID 
ORDER BY CustomerID, StartDate;
