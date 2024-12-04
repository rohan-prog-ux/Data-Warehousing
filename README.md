# Data-Warehousing
Designed and implemented a star schema database using PySpark to enable efficient data warehousing and analysis of historical data.


This SQL script creates a schema named "star-schema" and several tables inside that schema including "customers", "employees", "products", "fact_starschema", and "TimeDimension".
Next, it creates the "customers" table with columns such as CustomerID, CompanyName, ContactName, etc. The "employees" table is created with columns such as EmployeeID, LastName, FirstName, etc. The "products" table is created with columns such as ProductID, ProductName, SupplierID, etc.
The "fact_starschema" table is created with columns such as CustomerID, employeeID, required date, etc. It also has foreign key constraints to the "customers", "employees", and "product" tables.
Lastly, the script creates the "TimeDimension" table with columns such as DateID, date, year, month, etc. This table can be used as a dimension table in a data warehouse to analyze data based on time periods.

Denormalization is the process of combining tables in a database schema to reduce the number of joins needed to execute a query, which can improve query performance. In an OLAP (Online Analytical Processing) database, denormalization is often used to create star or snowflake schema designs, which allow for efficient aggregation and reporting.
In the given MySQL script, the star-schema database is created with five tables: customers, employees, fact table, time dimension, products, and one fact table fact_northwind. To denormalize the Northwind database to fit into the Star-schema OLAP model, the following steps can be taken:
1.	Identify the fact table: In the Northwind database, the Employees table can be used as the fact table, as it contains the data to be analyzed.
2.	Identify the dimensions: The dimensions are the entities that describe the facts in the fact table. In the case of the Orders table, the dimensions would be Customers, Employees, Products, and Shippers.
3.	Create dimension tables: Create separate tables for each dimension, with each table containing the attributes for that dimension. For example, the Customers table would contain columns such as customerNumber, customerName, contactLastName, etc.
4.	Create the fact table: The fact table, fact_northwind, can be created by combining the relevant columns from the Orders table with foreign keys to the dimension tables. For example, the fk_customerNumber column in the fact table would correspond to the customerNumber column in the Customers table.
5.	Populate the tables: Data can be extracted from the Northwind database and inserted into the appropriate tables in the star-schema database.
Note that denormalization is a trade-off between query performance and data redundancy. Combining tables increases data redundancy, which can lead to data inconsistencies if not managed properly. Therefore, it is important to carefully consider the requirements and constraints of the database before denormalizing it.
![image](https://github.com/user-attachments/assets/aa1d747f-b270-450d-9e2a-578f629e637a)
