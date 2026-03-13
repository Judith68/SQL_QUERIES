# SQL Interview Practice Queries

## Overview
This repository contains **40 queries** commonly asked in **Data Analyst / SQL interview assessments**.  
The queries are organized from **Beginner to Advanced** level and cover topics such as:

- Basic SELECT and filtering
- Aggregations and GROUP BY
- JOINs between tables
- Window functions and ranking
- Advanced metrics like Customer Lifetime Value and Percentage Contribution

All table and column names are **generic** and **no real customer or sensitive data** is included.  
These queries are designed for learning, practice, and portfolio demonstration.

---

## Table Structure

### Customers
| Column Name   | Description                 |
|---------------|----------------------------|
| CustomerID    | Unique identifier for customer |
| FirstName     | Customer first name          |
| LastName      | Customer last name           |
| Country       | Customer country             |
| CustomerType  | Type/category of customer    |

### Products
| Column Name   | Description                 |
|---------------|----------------------------|
| ProductID     | Unique identifier for product |
| ProductName   | Name of the product          |
| Category      | Product category             |
| Price         | Price of the product         |
| Currency      | Currency used                |

### Orders
| Column Name   | Description                 |
|---------------|----------------------------|
| OrderID       | Unique identifier for order  |
| CustomerID    | Reference to customer       |
| OrderDate     | Date of the order           |

### OrderDetails
| Column Name   | Description                 |
|---------------|----------------------------|
| OrderDetailID | Unique identifier           |
| OrderID       | Reference to Orders         |
| ProductID     | Reference to Products       |
| Quantity      | Number of items ordered     |
| TotalAmount   | Total revenue for the line  |

---

## Query Categories

### Beginner
- Display all customers, products, and orders
- Filtering by country, category, price
- Count customers and products
- Show top N results

### Intermediate
- Total revenue, total quantity sold
- Aggregations per product and category
- Customer spending totals
- Average prices and revenue by currency

### Joins
- Orders with customer names
- Products purchased per order
- Customer-product-quantity relationships
- Customers with no orders
- Top/least purchased products

### Advanced
- Customer ranking by spending
- Monthly revenue trends
- Running totals
- Top-selling products in each category
- Customer Lifetime Value (CLV)
- Average Order Value (AOV)
- Repeat customers
- Percentage contribution per category to total revenue

---

## How to Use
1. Clone this repository:
```bash
git clone https://github.com/<JUDITH68>/sql-interview-queries.git