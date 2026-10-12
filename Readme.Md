# 🚀 Mini Projects Overview & Key Analytics

---

### 🔹 MINI PROJECT 01: SQL Foundations & Database Operations

* **Objective:** Build strong SQL foundations by creating, populating, and altering relational databases and tables.
* **Skills Covered:** `CREATE DATABASE`, `CREATE TABLE`, `INSERT`, `UPDATE`, `DELETE`, `ALTER TABLE`, Column Renaming, Modifying Table Structures, `CASE` Statements.

#### Core Deliverables & Tasks Solved:
1. **Database & Schema Setup:** Defined structured relational tables with strict data types and constraints.
2. **Data Ingestion:** Executed multi-row `INSERT` statements to populate baseline employee and organizational records.
3. **Table Modifications:** Modified active table structures using `ALTER TABLE` to add new fields and rename/alter existing columns.
4. **DML Data Operations:** Updated existing records to reflect organizational changes and executed targeted `DELETE` statements to purge invalid entries.
5. **Conditional Logic:** Built dynamic employee ratings and tier categorizations using `CASE` statements.

---

### 🔹 MINI PROJECT 02: ClassicModels Query Challenge

* **Objective:** Explore retail sales and corporate salary datasets to answer structured business questions regarding customer geography, order payments, and product pricing.
* **Skills Covered:** `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, `LIKE`, `IN`, `LIMIT`, `OFFSET`, Aggregate Functions (`SUM`, `AVG`, `MIN`, `MAX`, `COUNT`), Subqueries, Filtering, Sorting.

#### Core Deliverables & Tasks Solved:
* **Customer Analysis:**
  * Queried customer geographical locations, credit limits, localized customer searches, and sales representative assignments.
  * Analyzed customer payment activity and credit limit distributions across territories.
* **Product Analysis:**
  * Analyzed product line structures, MSRP pricing variances, stock quantities, and product search filtering.
  * Evaluated inventory stock levels to identify products requiring immediate replenishment.
* **Payment Analytics:**
  * Filtered and aggregated payment transaction dates, total revenue generated, average customer payments, and transaction extremes (`MIN`/`MAX`).

---

### 🔹 MINI PROJECT 03: Data Cleaning & Transformation

* **Objective:** Work with inconsistent and incomplete raw data, using SQL to clean, standardize, and transform fields.
* **Skills Covered:** `NULL` Handling (`COALESCE`), String Manipulation (`TRIM`, `SUBSTR`, `INSTR`, `REPLACE`), Duplicate Detection, Data Standardization, `UPDATE`, Conditional Parsing (`CASE`), Inconsistency Audits.

#### Core Deliverables & Tasks Solved:
1. **Missing Values:** Identified and handled missing information using `COALESCE` to replace `NULL` values in customer names, job titles, and locations with standardized defaults.
2. **Name & String Standardization:** Applied `TRIM` and string functions to strip trailing spaces and clean customer name entries.
3. **Email & Phone Cleaning:** Sanitized phone numbers by stripping non-numeric characters and validated email formats.
4. **Duplicate Detection:** Identified redundant records across customer and transactional tables.
5. **Data Inconsistency Audit & Product Transformation:** Extracted structured pay metrics (annualized INR metrics) from raw text strings using `CASE` and pattern matching (`LIKE '%/yr%'`, `'%/mo%'`) while auditing logically conflicting entries.

---

### 🔹 MINI PROJECT 04: Relational Analysis with JOINS

* **Objective:** Connect information stored across multiple relational tables to answer cross-functional business questions.
* **Skills Covered:** `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `SELF JOIN`, `CROSS JOIN`, Multiple-Table JOINS, Aggregation with JOINS, Filtering Joined Data.

#### Core Deliverables & Tasks Solved:
1. **Customer & Payment Integration:** Joined customer profiles with payment ledgers to analyze total spend per account.
2. **Employee & Office Mapping:** Connected employees with their physical office locations to evaluate regional headcount.
3. **Order & Product Analysis:** Linked order line items with product catalog tables to track top-selling stock items and fulfillment status.
4. **Sales Representative Attribution:** Associated customers directly with their assigned sales representatives to evaluate sales agent performance.
5. **Employee Hierarchy (SELF JOIN):** Executed `SELF JOIN` queries on manager ID attributes to reconstruct employee-manager organizational hierarchies.
6. **Missing Relationships Detection:** Leveraged `LEFT JOIN ... WHERE key IS NULL` to isolate inactive customers without orders and products that have never been sold.

---

### 🔹 MINI PROJECT 05: Advanced SQL — Window Functions

* **Objective:** Perform advanced comparative, ranking, running-total, time-based, and moving-average analytics using Window Functions and Common Table Expressions (CTEs).
* **Skills Covered:** `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `PARTITION BY`, `ORDER BY`, `SUM() OVER()`, `LAG()`, Running Totals, Moving Averages, CTEs.

#### Core Deliverables & Tasks Solved:
1. **Product Ranking:** Applied `ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()` partitioned by product line to evaluate product performance.
2. **Running Totals:** Computed cumulative payment values over time using frame-bound window aggregation (`SUM(...) OVER (ORDER BY ...)`).
3. **Top Products per Line:** Utilized CTEs wrapped with window ranking filters to isolate the top-ranked products per line.
4. **Month-over-Month (MoM) Growth Analysis:** Implemented `LAG()` functions to compare payment totals across months and compute percentage growth.
5. **Moving Averages:** Calculated rolling 3-month moving averages for sales volume trends.