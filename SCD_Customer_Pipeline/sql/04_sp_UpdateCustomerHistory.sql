-- ================================================
-- 🧠 Stored Procedure: SCD Type 2 Automation
-- File: 04_sp_UpdateCustomerHistory.sql
-- Author: Roy Phelps
-- Description:
--   - Compares current history data to the latest staging snapshot
--   - Step 1: Updates IsCurrent = 0 and sets EndDate on changed records
--   - Step 2: Inserts new rows with StartDate = LastUpdated
--   - Ensures only one current version exists per CustomerID
--   - To run: EXEC sp_UpdateCustomerHistory;
-- ================================================


CREATE OR ALTER PROCEDURE sp_UpdateCustomerHistory
AS
BEGIN
    SET NOCOUNT ON;

    -- STEP 1: Update old rows in history that have changed
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

    -- STEP 2: Insert new rows for updated customers
    WITH JustUpdated AS (
        SELECT *
        FROM dbo.Customer_History_WithID
        WHERE IsCurrent = 0 
          AND EndDate = (SELECT MAX(LastUpdated) FROM dbo.Customer_Staging)
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
END;
