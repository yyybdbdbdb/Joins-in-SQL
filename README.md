# 📊 SQL Joins & Constraints – 8 Day Learning Project

Welcome to my SQL practice repository! This project documents my 8-day learning sprint focused on mastering **Joins**, **Constraints**, and foundational **Database Design** using **MySQL Workbench**.

---

## 🔗 Topics Covered

### 1. SQL Joins
- ✅ **INNER JOIN** – Fetch common records across tables  
- ✅ **LEFT JOIN** – Get all records from the left table with matches from the right  
- ✅ **RIGHT JOIN** – Opposite of LEFT JOIN  
- ✅ **FULL OUTER JOIN** – (Simulated using `UNION` of LEFT and RIGHT JOINs in MySQL)

### 2. Constraints
- 🔑 **Primary Key**
- 🔗 **Foreign Key**
- 🧩 **UNIQUE**
- 🚫 **NOT NULL**

### 3. Key Concepts
- 🔒 **Data Integrity**
- ✅ **Data Validation**
- 🔐 **Data Security**
- ⚙️ **Query Optimization Basics**
- 📐 **Entity Relationship Diagram (ERD)** – Understanding table relationships

---

## 🧪 Sample Queries (Used in Practice)

### 🧵 Join Example: Products & Returns

```sql
SELECT 
  p.productname, 
  r.returnquantity, 
  ps.SubcategoryName, 
  pc.CategoryName
FROM products AS p
INNER JOIN returns AS r ON p.ProductKey = r.ProductKey
INNER JOIN product_subcategories AS ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN product_categories AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey;

