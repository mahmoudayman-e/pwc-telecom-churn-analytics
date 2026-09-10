# PwC Switzerland - Customer Risk & Churn End-to-End Analytics Project

## 📌 Project Overview
This repository showcases an enterprise-grade, end-to-end **Telecom Customer Churn & Risk Analysis** solution inspired by the **PwC Switzerland Virtual Internship**. This project bridges the gap between backend data manipulation and frontend executive reporting by combining **SQL** for relational database exploration and validation with **Power BI** for interactive, high-density visualization. 

The primary business objective is to empower corporate retention strategy teams to detect high-risk subscriber segments, audit daily customer service workloads, and proactively mitigate revenue leakage.

---

## 🛠️ Technical Toolkit & Skills Demonstrated
* **Database Engineering & Analytics (SQL):** Structured database initialization, data integrity verification, and authored complex analytical scripts utilizing aggregations, conditional filtering (`CASE WHEN`), and conditional grouping.
* **Business Intelligence (Power BI):** Designed comprehensive 2-page operational canvases with dynamic cross-filtering and responsive sidebar navigation.
* **Analytical Modeling (DAX):** Formulated highly performant custom measures (`CALCULATE`, `DIVIDE`, `SWITCH`) synchronized perfectly with SQL database thresholds.
* **Enterprise UI/UX Design:** Implemented a minimalist grid layout utilizing strategic, high-contrast orange visual anchors to focus user attention on critical operational risk indicators.

---

## 🗄️ SQL Data Exploration & Validation Examples
Before developing the visual reporting layer, the raw dataset was processed and queried using SQL to establish a verified baseline of corporate KPIs. Below are examples of the analytical queries applied to the database:

```sql
-- 1. Validating Macro Executive KPIs (7,043 Customers, 1,869 Churned, 26.54% Global Churn)
SELECT 
    COUNT(customerID) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Total_Churned_Customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 2) AS Global_Churn_Rate_Percentage,
    ROUND(SUM(TotalCharges), 2) AS Total_Historical_Revenue
FROM [01 Churn-Dataset];

-- 2. Quantifying Support Ticket Workloads (Should yield 2,955 Tech and 3,632 Admin tickets)
SELECT 
    SUM(numTechTickets) AS Total_Tech_Tickets,
    SUM(numAdminTickets) AS Total_Admin_Tickets
FROM [01 Churn-Dataset];
```

---

## 📊 Interactive Dashboard Layout & Features

### Page 1: Customer Risk Analysis (Executive View)
<img width="1193" height="668" alt="Customer Risk" src="https://github.com/user-attachments/assets/30e3957b-6681-4647-a42d-81ca798eedbb" />

Focuses heavily on identifying systemic risk variables, core operational bottlenecks, and macro-financial impacts.
* **Top Executive KPIs:** Displays Total Customers (7,043), Global Churn Rate (26.54%), Total Historical Revenue (\$16.06M), and an interactive gauge mapping lost accounts.
* **Operational Ticket Audit:** Highlights product friction by exposing critical support ticketing workloads: **2,955 Tech Tickets** and **3,632 Admin Tickets**.
* **Risk Categorization Trendlines:** Employs Line & Stacked Column charts to plot absolute account volumes against churn curves categorized by Contract Type, Years of Contract, and Selected Payment Methods.


---

### Page 2: Customer Demographics & Account Insights Page
<img width="1193" height="655" alt="Demographics   Services" src="https://github.com/user-attachments/assets/e4da86d3-d114-45b4-bcd2-81956416c7e1" />

Deep-dives into qualitative demographic attributes and individual service line penetration levels.
* **Demographic Segmentation:** Maps risk profiles utilizing Donut and Treemap charts broken down by Gender, Senior Citizen status, Partners, and Dependents.
* **Service Ecosystem Penetration:** Evaluates account health by tracking subscription percentage rates across core offerings including Phone Service, Online Security, Backup, Device Protection, and Tech Support.
* **Churn Density Distribution:** Features an Area Chart plotting total customer volumes against precise Monthly Charges to isolate exact pricing friction points.

---

## 🚀 Execution Instructions
1. Navigate to the `sql/` directory to run analytical queries on your preferred RDBMS.
2. Open the `.pbix` framework housed inside the `dashboard/` directory using **Power BI Desktop**.
3. Interact with the vertical sidebar slicers to cross-filter across demographic or
