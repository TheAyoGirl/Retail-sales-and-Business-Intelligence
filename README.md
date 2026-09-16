Project Overview

This project analyses retail sales data from 2023–2026 to understand sales performance, profitability, regional performance, product performance, discounting and returns.

The project follows a practical business intelligence workflow:

Excel → SQL Server → Power BI

The objective was to transform raw transactional data into actionable business insights through data cleaning, SQL analysis and an interactive Power BI dashboard.

Business Problem

A retail business needs to understand not only how much it sells, but also where and how it makes or loses money.

This analysis investigates:

How sales and profit have changed over time
Which regions generate the strongest financial performance
Which categories and sub-categories are most and least profitable
How discounting relates to profitability
Which products generate significant profits or losses
The scale and distribution of product returns
Project Objectives

The analysis aimed to:

Clean and prepare the retail transaction data.
Build a reliable analytical dataset using SQL Server.
Calculate key sales and profitability KPIs.
Identify regional, category and product-level performance patterns.
Analyse the relationship between discount levels and profit.
Analyse returned orders and their financial performance.
Build an interactive Power BI dashboard for business users.
Produce actionable business recommendations.
Dataset

Dataset: Sample Superstore

The dataset represents a fictional retail business and contains transactional information covering:

Orders
Customers
Products
Sales
Profit
Quantity
Discounts
Shipping
Geography
Product categories
Returns
Regional managers

The analysis covers 2023–2026.

Tools & Technologies
Tool	Purpose
Microsoft Excel	Initial data inspection, preparation and calculated columns
SQL Server	Data cleaning, validation and business analysis
Power BI	Interactive dashboard and data visualisation
Project Workflow
1. Data Preparation

The original Excel workbook was preserved as the raw source.

A working copy was created for preparation and additional analytical fields.

Calculated fields included:

Shipping Days
Profit Margin
Order Year
Order Month
Order Quarter
Returned

The prepared data was exported to CSV before being imported into SQL Server.

2. SQL Server

A dedicated SQL Server database was created:

RetailSalesBI

The database contains:

Orders
Returns
People
Orders_Clean
Data Cleaning

The SQL process included:

Data type correction
Removal of an unnecessary CSV index column
Product name field expansion
Numeric data type validation
Duplicate investigation
Transaction-level deduplication
Returns matching
Data validation

Two exact duplicate transaction rows were identified and removed from the analytical table.

The final analytical dataset contained:

10,192 transaction rows

with:

5,111 unique orders
804 unique customers
1,862 unique products

The original Orders table was retained as the raw source.

3. Key Performance Indicators
KPI	Result
Total Sales	$2,326,154
Total Profit	$292,274
Profit Margin	12.56%
Total Orders	5,111
Total Customers	804
Total Quantity	38,644
Return Rate	~5.8%
4. Sales & Profit Performance

Sales and profit both increased substantially across the analysis period.

Year	Sales	Profit	Margin
2023	$493,660	$51,661	10.46%
2024	$472,993	$62,021	13.11%
2025	$613,934	$82,665	13.46%
2026	$745,567	$95,927	12.87%

Between 2023 and 2026:

Sales increased by approximately 51%
Profit increased by approximately 86%
Profit margin improved overall

2026 recorded the highest sales and profit values in the dataset.

5. Regional Performance
Region	Sales	Profit	Margin
West	$739,814	$110,799	14.98%
East	$691,448	$94,860	13.72%
South	$391,722	$46,750	11.93%
Central	$503,171	$39,865	7.92%

The analysis highlights substantial differences between regional sales and profitability.

The Central region generated over $500K in sales but produced a considerably lower margin than the other regions.

6. Category Performance
Category	Sales	Profit	Margin
Technology	$839,893	$146,544	17.45%
Office Supplies	$731,893	$126,024	17.22%
Furniture	$754,367	$19,707	2.61%

Technology generated the highest profit.

Furniture generated substantial sales but significantly lower profitability.

At sub-category level, Tables and Bookcases were loss-making, while areas such as Copiers, Paper and Accessories generated stronger margins.

7. Discount & Profitability Analysis

Discounting was one of the most important findings from the analysis.

Discount Band	Sales	Profit	Margin
0%	$1,105,225	$326,683	29.56%
1–10%	$54,952	$9,100	16.56%
11–20%	$801,498	$92,500	11.54%
21–30%	$104,193	-$10,501	-10.08%
31–40%	$130,991	-$25,478	-19.45%
>40%	$129,295	-$100,030	-77.37%

Transactions with discounts above 20% were associated with negative profitability.

The analysis therefore identified high discounting as an area requiring closer management attention.

This represents an association within the dataset rather than proof that discounts alone caused the losses.

8. Product Performance
Highest Profit Product

Canon imageCLASS 2200 Advanced Copier

Sales: $61,600
Profit: $25,200
Profit Margin: 40.91%
Significant Loss-Making Product

Cubify CubeX 3D Printer Double Head

Sales: $11,100
Profit: -$8,880
Profit Margin: -80%

Several loss-making products were also associated with high discount levels.

This demonstrates the value of analysing profitability at product level rather than relying only on overall category performance.

9. Returns Analysis

The dataset contained:

296 returned orders
Approximately 5.8% of total orders

Returned orders were examined by category and sub-category to identify potential patterns.

The overall margin for returned orders was approximately 12.87%, compared with approximately 12.54% for non-returned orders.

Based on the available data, returns therefore did not appear to be the primary source of the overall profitability issues identified in the analysis.

10. Power BI Dashboard

An interactive three-page Power BI dashboard was developed.

Page 1 — Executive Overview

Provides a high-level view of:

Sales
Profit
Profit margin
Orders
Customers
Return rate
Sales and profit trends
Regional profitability
Category profitability
Segment sales
Page 2 — Profitability Analysis

Focuses on:

Sub-category profitability
Top 10 products by profit
Bottom 10 products by profit
Discount vs profit relationship
Page 3 — Returns & Business Insights

Focuses on:

Orders by return status
Returned orders by sub-category
Returned profit by sub-category
Return rate by category

All three pages use consistent Year, Region and Category slicers, allowing users to interactively explore the data.

11. Key Business Insights
Sales are growing

The business experienced substantial growth between 2023 and 2026, with both sales and profit increasing.

Revenue does not always translate into strong profitability

Furniture generated more than $750K in sales but produced only $19.7K in profit.

Regional performance varies

The Central region generated significant revenue but had a relatively low 7.92% margin.

High discounts require attention

Discounts above 20% were associated with negative profitability, with the highest discount band producing a substantial loss.

Product-level analysis reveals hidden issues

Some individual products generated significant losses despite contributing to overall sales.

Returns are relatively limited

Approximately 5.8% of orders were returned, and returned orders did not show substantially weaker overall margins.

12. Business Recommendations

Based on the findings, the business could:

1. Strengthen discount controls
Review high-discount transactions and introduce product-level profitability checks before applying substantial discounts.

2. Review loss-making products
Investigate pricing, costs and discounting for consistently loss-making products.

3. Investigate Furniture profitability
Examine Tables, Bookcases and other low-margin Furniture products to understand the underlying causes.

4. Investigate Central region performance
Review its product mix, pricing and discount patterns to understand the lower margin.

5. Monitor profitability alongside sales
Use both revenue and margin KPIs when evaluating business performance.

13. Project Outcome

This project demonstrates an end-to-end Business Intelligence workflow, from raw transactional data through preparation, SQL analysis and interactive visualisation.

The project demonstrates practical experience in:

Data cleaning
Data validation
SQL querying
KPI development
Profitability analysis
Business intelligence
Data visualisation
Dashboard design
Business-focused insight generation

The final outcome is an interactive Power BI dashboard supported by SQL analysis and an executive business report, providing a clear view of sales performance, profitability, discounting and returns.

Skills Demonstrated

Excel | SQL Server | Power BI | Data Cleaning | Data Analysis | Business Intelligence | KPI Development | Data Visualisation | Dashboard Development | Business Reporting
