         ######### 30-05-2025  Introduction to joins#######3
use joins;
select * from `returns - returns` limit 10 ;
select * from  `territories - territories` limit 10; 
select * from `calendar - calendar` limit 10;
select * from `customers - customers` limit 10;
select * from `products - products` limit 10;
select * from `product-categories - product-categories` limit 10;
select * from `product-subcategories - product-subcategories` limit 10;
select * from `returns - returns` as r inner join `territories - territories` as t 
on r.TerritoryKey = t.SalesTerritoryKey;
select * from `returns - returns` as r left join `territories - territories`  as t 
on r.TerritoryKey = t.SalesTerritoryKey;
select * from `products - products` as p right join `product-subcategories - product-subcategories` as ps
on p.ProductSubcategoryKey =ps.ProductSubcategoryKey 
select  p.productname , ps.subcategoryname , pc.categoryname from `products - products` as p inner join `product-subcategories - product-subcategories`  as ps 
on p.ProductSubcategoryKey = ps.ProductSubcategoryKey  inner join `product-categories - product-categories` as pc on pc.ProductCategoryKey = ps.ProductCategoryKey 
rename table `calendar - calendar` to calender;
rename table `customers - customers` to customers;
rename table `product-categories - product-categories` to product_categories;
rename table `product-subcategories - product-subcategories` to product_subcategories;
rename table `products - products` to products;
rename table `returns - returns` to returns;
rename table `sales-2015 - sales-2015` to sales_2015;
rename table `sales-2016 - sales-2016` to sales_2016;
rename table `sales-2017 - sales-2017` to sales_2017;
rename table `territories - territories` to territories;
select * from returns limit 10 ;
select * from  territories limit 10; 
select * from calender limit 10;
select * from customers limit 10;
select * from products limit 10;
select * from product_categories limit 10;
select * from product_subcategories limit 10;
select  p.productsize , p.productcost , p.productprice , p.productcolor ,pc.categoryname , ps.subcategoryname from products as p left join product_subcategories as ps 
on p.ProductSubcategoryKey =ps.ProductSubcategoryKey left join product_categories as pc on  pc.ProductCategoryKey = ps.ProductCategoryKey;
select * from products as p right join returns as r 
on p.ProductKey = r.ProductKey;
select  p.modelname , p.productname , p.productprice , ps.SubcategoryName , pc.CategoryName from products as p inner join product_subcategories as ps 
on p.ProductSubcategoryKey = ps.ProductSubcategoryKey inner join product_categories as pc on pc.ProductCategoryKey = ps.ProductCategoryKey

select * from products as p  left join returns as r on p.ProductKey = r.ProductKey
union 
select * from products as p  right join returns as r on p.ProductKey = r.ProductKey

select * from products as p  left join returns as r on p.ProductKey = r.ProductKey
union all 
select * from products as p  right join returns as r on p.ProductKey = r.ProductKey

######Constraints#########
1. data integrity 
2. data validalition 
3.data security 
4.query optimization 

########types of constraints#########

create table students (
roll_no int not null unique,
sname varchar (50) not null
);

create table students2( 
roll_no int primary key , 
sname varchar(50)) ;

create table orders( 
orderid int primary key , 
quantity int , 
price decimal(10,2),
constraint check_positive_amount check (quantity * price >0)
);
create table employees ( 
emp_id int primary key ,
name varchar(50) not null ,
age int default 25 );

###############301-07-2025  Advance Concepts in joins########333
 Foreign key 
 Entity relationship diagram 
   1.one - one 
   2.one - many 
   3. many - one 
   4. many - many 
    ### cross join ###
CREATE TABLE Colors (
    ColorID INT PRIMARY KEY,
    ColorName VARCHAR(50)
);

INSERT INTO Colors (ColorID, ColorName) VALUES
(1, 'Red'),
(2, 'Blue'),
(3, 'Green');   

select * from colors;

CREATE TABLE Sizes (
    SizeID INT PRIMARY KEY,
    SizeName VARCHAR(50)
);

INSERT INTO Sizes (SizeID, SizeName) VALUES
(1, 'Small'),
(2, 'Medium'),
(3, 'Large');

select * from sizes;

select * from colors cross join sizes;
SELECT c.ColorName, s.SizeName FROM Colors c CROSS JOIN  Sizes s;
   ##### Self join ######
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    ManagerID INT  -- references EmpID
);

INSERT INTO Employees (EmpID, EmpName, ManagerID) VALUES
(1, 'Alice', NULL),       -- CEO (no manager)
(2, 'Bob', 1),            -- Reports to Alice
(3, 'Charlie', 1),        -- Reports to Alice
(4, 'David', 2),          -- Reports to Bob
(5, 'Eve', 2);            -- Reports to Bob

select * from employees; 
SELECT e.EmpName AS Employee, m.EmpName AS Manager FROM  Employees e
LEFT JOIN  Employees m ON e.ManagerID = m.EmpID;

SELECT e.empid , e.empname as Employee , m.EmpName as Manager from Employees e
left join Employees m on e.Managerid = m.EmpID; 

select ifnull(managerid , 0) as ManagerID from employees;

CREATE TABLE Customers1 (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);
INSERT INTO Customers1 (CustomerID, CustomerName, Email, Phone) VALUES
(1, 'Alice', 'alice@example.com', '9876543210'),
(2, 'Bob', NULL, '9123456789'),
(3, 'Charlie', 'charlie@example.com', NULL),
(4, 'David', NULL, NULL);

select * from customers1;

SELECT CustomerName, IFNULL(Email, 'No Email Provided') AS EmailStatus FROM Customers1;
SELECT CustomerName, COALESCE(Phone, 'No Phone') AS ContactNumber FROM Customers1;
SELECT CustomerName, COALESCE(Email, Phone, 'No Contact Info') AS PreferredContact FROM Customers1;
alter table customers1
add Salary decimal(10,2) ,
add Bonus decimal(10,2) ; 

update customers1
set  salary = case 
when customerid = 1 then  5000
when customerid = 3 then 6000
when customerid = 4 then 10000
else Salary
 end ,
 Bonus = case
when customerid = 2 then 5000
when customerid = 4 then 12000
Else bonus
 end ;
select customername , salary , bonus , coalesce(salary, bonus, 0) as payout from customers1;

###### Practice Questions#######
## 1. Total returns by product subcategory & product categoy ####


select ps.subcategoryname , pc.categoryname , sum(r.returnquantity) as total_qr 
from returns  r
 inner join products as p on p.productkey = r.productkey
 inner join product_subcategories as ps on p.productsubcategorykey = ps.productsubcategorykey 
 inner join product_categories as pc on ps.ProductCategoryKey = pc.ProductCategoryKey 
 group by ps.subcategoryname , pc.categoryname
 
 ###########3  2. territories with a TQR greater then 200 ####

select t.SalesTerritoryKey , sum(r.returnquantity) as TQR 
from returns r 
inner  join  territories as t on t.SalesTerritoryKey = r.TerritoryKey 
Group by SalesTerritoryKey 
having sum(r.returnquantity) >200 
order by sum(r.returnquantity) desc ;
 
 ############ 3. Products with no returns #######

 select p.productname  from products as p  
 left join returns as r on p.productkey = r.productkey 
 where r.returnquantity is null ; 
 
 #########  4.Top 5 productsubcategory by TQR ######


select ps.SubcategoryName , sum(r.returnquantity) as tqr 
from returns as r
inner join products as p on r.productkey = p.productkey 
inner join product_subcategories as ps on  p.productsubcategorykey = ps.productsubcategorykey 
group by subcategoryname 
order by sum(r.returnquantity)  desc limit 5;
 
 select ps.SubcategoryName , sum(r.returnquantity) as tqr 
from returns as r
inner join products as p on p.productkey = r.productkey 
inner join product_subcategories as ps on  ps.productsubcategorykey = p.productsubcategorykey 
group by subcategoryname 
order by sum(r.returnquantity)  desc limit 5;

########### 5.Total Product cost & price by category & sub category

select pc.CategoryName , ps.SubcategoryName, sum(p.productcost) as P_C , sum(p.productprice) as P_P
from products as p 
inner join product_subcategories as ps on p.ProductSubcategoryKey = ps.ProductSubcategoryKey
inner join product_categories as pc on ps.ProductCategoryKey = pc.ProductCategoryKey 
group by pc.CategoryName , ps.SubcategoryName;

select pc.CategoryName , ps.SubcategoryName, round(sum(p.productcost),2) as P_C , round(sum(p.productprice),2) as P_P
from products as p 
inner join product_subcategories as ps on p.ProductSubcategoryKey = ps.ProductSubcategoryKey
inner join product_categories as pc on ps.ProductCategoryKey = pc.ProductCategoryKey 
group by pc.CategoryName , ps.SubcategoryName 
having round(sum(p.productcost),2)>200;
order by round(sum(p.productprice),2) desc;

##########  Top 5 customers or productname by total sales , quantity ##########
 select * from returns limit 10 ;
select * from  territories limit 10; 
select * from calender limit 10;
select * from customers limit 10;
select * from products limit 10;
select * from product_categories limit 10;
select * from product_subcategories limit 10; 

select p.productname , round(sum(p.productprice) ,2) as P_P , round(sum(r.returnquantity),2) as TQR 
from returns as r 
inner join products as p on r.productkey = p.productkey
group by  p.productname
order by round(sum(p.productprice) ,2) desc , round(sum(r.returnquantity),2)  desc limit 5;


###################  01-07-2025 Case statements ########
 select * from returns limit 10 ;
select * from  territories limit 10; 
select * from calender limit 10;
select * from customers limit 10;
select * from products limit 10;
select * from product_categories limit 10;
select * from product_subcategories limit 10; 

select t.region ,
round(avg(p.productcost),1) as avg_PC ,
case 
when round(avg(p.productcost),1) > 300 then "High Cost"
when round(avg(p.productcost),1)<150 then "Low Cost"
else "Moderate Cost"
end as Cost_Category 
 from products as p
 join Product_Subcategories as ps on p.ProductSubcategoryKey = ps.ProductSubcategoryKey
  join product_categories as pc on ps.ProductCategoryKey = pc.ProductCategoryKey
  join returns as r on p.productkey = r.productkey 
join territories as t on  r.TerritoryKey = t.SalesTerritoryKey
 group by t.region;
	

select * from sales_2015;
select territorykey , 
sum(case when orderquantity > 2 then orderquantity else 0 end) as high_perf_sales ,
sum(case when orderquantity between 1 and 2  then orderquantity else 0 end) as medium_perf_sales,
sum(case when orderquantity < 1 then orderquantity else 0 end) as low_perf_sales
from sales_2015 
group by territorykey;

 select * from returns limit 10 ;
select * from  territories limit 10; 
select * from calender limit 10;
select * from customers limit 10;
select * from products limit 10;
select * from product_categories limit 10;
select * from product_subcategories limit 10; 

select pc.categoryname , ps.subcategoryname , sum(r.returnquantity),
case
when sum(r.returnquantity) >100 then "High Returns"
when sum(r.returnquantity) >50 then "Medium Returns"
else "Low Returns" 
end as Return_Segment
from products as p 
inner join `product_subcategories` as ps on p.ProductSubcategoryKey= ps.ProductSubcategoryKey
inner join `product_categories` as pc on ps.ProductCategoryKey= pc.ProductCategoryKey
inner join returns as r on p.ProductKey = r.ProductKey
group by pc.categoryname , ps.subcategoryname;

 select pc.categoryname , ps.subcategoryname , sum(r.returnquantity),
case
when sum(r.returnquantity) >100 then "High Returns"
when sum(r.returnquantity) >50 then "Medium Returns"
else "Low Returns" 
end as Return_Segment
from products as p 
inner join `product_subcategories` as ps on p.ProductSubcategoryKey= ps.ProductSubcategoryKey
inner join `product_categories` as pc on ps.ProductCategoryKey= pc.ProductCategoryKey
inner join returns as r on p.ProductKey = r.ProductKey
group by pc.categoryname , ps.subcategoryname
order by  sum(r.returnquantity) desc limit 20 offset 5;

with  avgcatprice as 
( 
select ps. productsubcategorykey , avg(p.productprice) as avg_price
 from products as p 
join product_subcategories as ps
on p.productsubcategorykey = ps.productsubcategorykey
group by ps.productsubcategorykey 
)
select * from avgcatprice;

with  avgcatprice as 
( 
select ps. productsubcategorykey , SubcategoryName , avg(p.productprice) as avg_price
 from products as p 
join product_subcategories as ps
on p.productsubcategorykey = ps.productsubcategorykey
group by ps.productsubcategorykey , SubcategoryName
)
select * from avgcatprice;

with  avgcatprice as 
( 
select ps. productsubcategorykey , SubcategoryName , pc.CategoryName,  avg(p.productprice) as avg_price
 from products as p 
join product_subcategories as ps
on p.productsubcategorykey = ps.productsubcategorykey
join product_categories as pc 
on ps.ProductCategoryKey = pc.ProductCategoryKey
group by ps.productsubcategorykey , SubcategoryName , pc.CategoryName
)
select * from avgcatprice;

with  avgcatprice as 
( 
select ps. productsubcategorykey , round(avg(p.productprice),1) as avg_price
 from products as p 
join product_subcategories as ps
on p.productsubcategorykey = ps.productsubcategorykey
group by ps.productsubcategorykey 
)
select p.productkey  , p.productname , p.productprice , acp.avg_price  from products as p
join avgcatprice as acp
on p.productsubcategorykey = acp.productsubcategorykey 
where p.productprice > acp.avg_price;
select * from avgcatprice;

select * from returns limit 10 ;
select * from  territories limit 10; 
select * from calender limit 10;
select * from customers limit 10;
select * from products limit 10;
select * from product_categories limit 10;
select * from product_subcategories limit 10; 

with returnsbycats as ( 
select pc.categoryname , sum(r.returnquantity) as total_returns from returns as r 
inner join products as p  on r.productkey = p.productkey 
inner join product_subcategories as ps on p.ProductSubcategoryKey = ps.ProductSubcategoryKey
inner join product_categories as pc on ps.ProductCategoryKey = pc.ProductCategoryKey
group by pc.categoryname 
) 
select * from returnsbycats;
select * from sales_2015; 

 with revenue_by_category as (
 select pc.categoryname , sum(p.productprice * s.orderquantity) as total_rev
from sales_2025 as s 
join products as p on s.productkey = p.productkey 
join product_subcategories as ps on p.productsubcategorykey = ps.productsubcategorykey
join product_categories as pc on ps.productcategorykey = pc.productcategorykey
group by pc.categoryname 
) 
select * from revenue_by_category;

select rbc.categoryname , rbc.totalreturns , rvc .total rev from returns_by_cat as rbc 
join revenue by category as rvc 
or rbc.categoryname = rvc. categoryname;


############### again ##############
with returnsbycats as (
select pc.categoryname , sum(r.returnquantity) as totalreturns
from returns as r 
join products as p 
on r.productkey = p.productkey 
join product_subcategories as ps on p.ProductSubcategoryKey = ps.ProductSubcategoryKey
join product_categories as pc on ps.ProductCategoryKey = pc.ProductCategoryKey
group by pc.CategoryName
),
revenuebycategory as (
select pc.categoryname , sum(p.productprice * s.orderquantity) as totalrev from  sales_2015 as s 
join products as p on s.productkey = p.productkey 
join product_subcategories as ps  on p.productsubcategorykey = ps.productsubcategorykey 
join product_categories as pc on ps.productcategorykey = pc.productcategorykey
group by pc.categoryname
)
 select rbc.categoryname , rbc.totalreturns , rvc.totalrev
 from returnsbycats as rbc
 join revenuebycategory as rvc 
 on rbc.categoryname = rvc.categoryname 
 
select * from products 
###### avg cost by category name ######3

with avgcats as (
select pc.categoryname , round(avg(p.productcost),1) as avgcost
 from products as p 
join product_subcategories as ps on p.productsubcategorykey = ps.productsubcategorykey
join product_categories as pc on ps.productcategorykey = pc.productcategorykey
group by pc.categoryname 
) 
select * 
total_rev as (
select pc.categoryname , sum(p.productprice * s.orderquantity) as totalrev
from sales_2015 as s 
join p.products as p on s.productkey = p.productkey 
join product_subcategories as ps on p.productsubcategorykey = ps.productsubcategorykey 
join product_categories as pc on ps.productcategorykey = pc.productcategorykey 
group by pc.categoryname 
)
select  * from total_rev;




