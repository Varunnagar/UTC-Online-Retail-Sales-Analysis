# 🛒 UTC Online Retail Sales Analytics

---

## 📌 Project Overview

This project analyzes an e-commerce transaction dataset to understand **sales performance, customer behavior, product demand, cancellations, and revenue trends**.

The project follows a complete data analytics workflow:

> **Data Collection → Data Cleaning → Data Transformation → SQL Analysis → Dashboard Development → Business Insights**

Using **Python, MySQL, and Power BI**, raw transactional data was cleaned, analyzed, and transformed into an interactive dashboard for better decision-making.

---

## 🎯 Project Objectives

The main objectives of this project are to:

- 📊 Analyze overall sales and revenue performance.
- 📈 Identify monthly and yearly sales trends.
- 🏆 Find the top-performing products.
- 👥 Analyze customer purchasing behavior.
- 🔄 Identify repeat customers.
- ❌ Analyze cancelled transactions and cancellation rates.
- 🌍 Understand sales distribution across different countries.
- 💡 Generate actionable business insights through an interactive dashboard.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| 🐍 **Python** | Data cleaning and preprocessing |
| 🐼 **Pandas** | Data manipulation and analysis |
| 🔢 **NumPy** | Numerical operations |
| 📊 **Matplotlib / Seaborn** | Exploratory data visualization |
| 🗄️ **MySQL** | Data storage and SQL analysis |
| 📈 **Power BI** | Interactive dashboard development |
| 📄 **CSV** | Dataset storage and transfer |

---

# 📂 Dataset Information

The dataset contains transactional information from an online retail business.

### Important Columns

| Column | Description |
|--------|-------------|
| `InvoiceNo` | Unique invoice number for each transaction |
| `StockCode` | Unique product code |
| `Description` | Product description |
| `Quantity` | Number of products purchased |
| `InvoiceDate` | Date and time of transaction |
| `UnitPrice` | Price per product |
| `CustomerID` | Unique customer identifier |
| `Country` | Customer's country |

---

## 🧹 Data Cleaning & Preprocessing

The raw dataset required several preprocessing steps before analysis.

### Cleaning Steps Performed

- Checked dataset structure and data types.
- Identified missing values.
- Handled missing data where required.
- Removed unnecessary columns for analysis.
- Converted `InvoiceDate` into a proper date format.
- Created additional date-related columns:
  - 📅 Year
  - 📆 Month
  - 🔢 Day
- Identified cancelled transactions using the invoice number.
- Separated cancelled and completed transactions.
- Checked for duplicate records.
- Created calculated fields required for analysis.

### Revenue Calculation

```python
df['Revenue'] = df['Quantity'] * df['UnitPrice']
