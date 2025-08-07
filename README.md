# 🔁 SCD Type 2 Customer Pipeline

This project demonstrates a simplified but complete implementation of a Slowly Changing Dimension (SCD) Type 2 pipeline using SQL and CSV-based data. It's designed for hands-on practice with concepts used in data warehousing and data engineering.

---


---

## 💡 Features

- ✅ Simulates **SCD Type 2 logic** with `StartDate`, `EndDate`, and `IsCurrent` tracking
- ✅ Reusable stored procedure for updates
- ✅ Staging vs historical data separation
- ✅ Step-by-step SQL script execution
- ✅ Clean star schema-friendly format

---

## ⚙️ How to Run

1. Set up a local SQL Server environment
2. Run `01_create_database_and_tables.sql` to create base objects
3. Run `02_load_initial_data.sql` to load initial customers
4. Run `03a_insert_fresh_data.sql` to simulate changes
5. Use `05_run_stored_procedure.sql` to call the stored proc
6. Run `06_verify_history_output.sql` to confirm history updates

---

## 📚 Learnings

This project is great for:

- Understanding dimensional modeling (SCD Type 2)
- Practicing staging-to-history workflows
- Preparing for data engineering or BI interviews
- Building portfolio-ready pipeline examples

---

## 👨‍💻 Author

**Roy Phelps**  
🧠 Data Analytics | Power BI | SQL | AI/ML Enthusiast  
💼 [LinkedIn](https://www.linkedin.com/in/royphelps1)

---

## 🚧 Future Plans

- Add parameterized stored proc (e.g., dynamic LastUpdated)
- Integrate with Power BI semantic model
- Convert flat files into automated ETL flow

---

