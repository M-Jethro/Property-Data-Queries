-- finding the unique products in all transactions
select count(distinct(productid))
from orderdetails;

-- total orders made per product
select distinct(productid), sum(quantity) 
from orderdetails
group by productid;

-- which product category has the most products?
select productcategory,
       count(productname) 'Number of Products'
from products
group by productcategory 
order by 'Number of Products' desc;

-- finding the states with the most stores
select propertystate, 
	count('prop id') 'Number of Properties'
from propertyinfo
group by propertystate 
order by 2 desc;

-- finding the top 5 productids with the most quantities sold as well as their sales value

select od.productid,
       p.productname,
	   sum(od.quantity),
       p.price * sum(od.quantity) as 'Total Revenue'
from orderdetails od
join products p
on od.productid = p.productid
group by od.productid
order by 3 desc
limit 5;

-- which properties sold brought in the most revenue?
select od.propertyid,
	   sum(od.quantity) as 'units sold',
       p.price * sum(od.quantity) as 'Total Revenue'
from orderdetails od
join products p
on od.productid = p.productid
group by od.productid
order by 3 desc
limit 5;

-- which top 5 cities sold the most properties?
select pi.propertycity,
       pi.propertystate,
       od.propertyid,
	   sum(od.quantity) 'Total Units',
       p.price * sum(od.quantity) as 'Total Revenue'
from orderdetails od
join products p
on od.productid = p.productid
join propertyinfo pi
on od.propertyid = pi.propertyid
group by pi.propertycity
order by 5 desc
limit 5;

-- finding the product category that has the most products
select  productcategory,
        count(productname) 'Number of Products'
from products
group by productcategory
order by 1 desc;

-- finding the products with the most sales in terms of quantity
select p.productname,
       od.productid,
       p.price,
	   sum(od.quantity) * p.price 'Sales',
       sum(od.quantity) 'Units sold'
from orderdetails od
join products p
on od.productid = p.productid
group by od.productid
order by 5 desc
limit 10;

-- top products in each of the cities. Here we join 3 tables
select p.propertycity,
       ps.productname,
       (sum(od.quantity) * ps.price) sales
from orderdetails od
join propertyinfo p
on od.propertyid = p.propertyid
join products ps
on od.productid = ps.productid
where p.propertycity = 'Las Vegas' -- one can choose whichever city they need
group by ps.productname
order by sales desc
limit 10;