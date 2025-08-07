-- ================================================
-- 📥 Load Initial Sample Data
-- File: 02_load_sample_data.sql
-- Author: Roy Phelps
-- Description:
--   - Inserts sample records into staging and history tables
--   - Used for testing SCD Type 2 update/insert logic
-- ================================================

-- Load sample data into staging (fresh feed)
INSERT INTO dbo.Customer_Staging (CustomerID, Name, City, Balance, LastUpdated)
VALUES
(1, 'Alpha Co', 'Boston', 100, '2024-10-01 08:00:00'),
(2, 'Beta Inc', 'Chicago', 150, '2024-10-01 08:00:00'),
(3, 'Gamma Corp', 'Denver', 200, '2024-10-01 08:00:00');

-- Optional: Seed some initial history
INSERT INTO dbo.Customer_History_WithID (
    CustomerID, Name, City, Balance, StartDate, EndDate, IsCurrent
)
VALUES
(1, 'Alpha Co', 'Boston', 90, '2024-09-01 08:00:00', '2024-10-01 08:00:00', 0),
(1, 'Alpha Co', 'Boston', 100, '2024-10-01 08:00:00', NULL, 1),
(2, 'Beta Inc', 'Chicago', 120, '2024-09-01 08:00:00', NULL, 1);
