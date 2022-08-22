create database if not exists E_Commerce;
use e_commerce;

create table if not exists supplier(
supp_id int primary key,
supp_name varchar(50) not null,
supp_city varchar(50),
supp_phone varchar(10) not null
);
create table if not exists customer(
cus_id int not null,
cus_name varchar(50) not null,
cus_phone varchar(10) not null,
cus_city varchar(50) not null,
cus_gender char,
primary key(cus_id)
);
create table if not exists product(
pro_id int not null,
pro_name varchar(20) not null default "Dummy",
pro_desc varchar(60),
cat_id int not null,
primary key(pro_id),
foreign key(cat_id) references category(cat_id)
);
create table if not exists supplier_Pricing(
pricing_id int not null,
pro_id int not null,
supp_id int not null,
supp_price int default 0,
primary key(pricing_id),
foreign key(pro_id) references product(pro_id)
);
drop table supplier_pricing;
create table if not exists supplier_Pricing(
pricing_id int not null,
pro_id int not null,
supp_id int not null,
supp_price int default 0,
primary key(pricing_id),
foreign key(pro_id) references product(pro_id),
foreign key(supp_id) references supplier(supp_id)
);
create table if not exists orders(
ord_id int not null,
ord_amount int not null,
ord_date date,
cus_id int not null,
pricing_id int not null,
primary key(ord_id),
foreign key(cus_id) references customer(cus_id),
foreign key(pricing_id) references supplier_pricing(pricing_id)
);
create table if not exists rating(
rat_id int not null,
ord_id int not null,
rat_ratstars int not null,
primary key(rat_id),
foreign key(ord_id) references orders(ord_id)
);

INSERT INTO SUPPLIER VALUES(1,"Rajesh Retails","Delhi",'1234567890');
INSERT INTO SUPPLIER VALUES(2,"Appario Ltd.","Mumbai",'2589631470');
INSERT INTO SUPPLIER VALUES(3,"Knome products","Banglore",'9785462315');
INSERT INTO SUPPLIER VALUES(4,"Bansal Retails","Kochi",'8975463285');
INSERT INTO SUPPLIER VALUES(5,"Mittal Ltd.","Lucknow",'7898456532');

INSERT INTO CATEGORY VALUES( 1,"BOOKS");
INSERT INTO CATEGORY VALUES(2,"GAMES");
INSERT INTO CATEGORY VALUES(3,"GROCERIES");
INSERT INTO CATEGORY VALUES (4,"ELECTRONICS");
INSERT INTO CATEGORY VALUES(5,"CLOTHES");

INSERT INTO PRODUCT VALUES(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2);
INSERT INTO PRODUCT VALUES(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5);
INSERT INTO PRODUCT VALUES(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4);
INSERT INTO PRODUCT VALUES(4,"OATS","Highly Nutritious from Nestle",3);
INSERT INTO PRODUCT VALUES(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1);
INSERT INTO PRODUCT VALUES(6,"MILK","1L Toned MIlk",3);
INSERT INTO PRODUCT VALUES(7,"Boat EarPhones","1.5Meter long Dolby Atmos",4);
INSERT INTO PRODUCT VALUES(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5);
INSERT INTO PRODUCT VALUES(9,"Project IGI","compatible with windows 7 and above",2);
INSERT INTO PRODUCT VALUES(10,"Hoodie","Black GUCCI for 13 yrs and above",5);
INSERT INTO PRODUCT VALUES(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1);
INSERT INTO PRODUCT VALUES(12,"Train Your Brain","By Shireen Stephen",1);


INSERT INTO SUPPLIER_PRICING VALUES(1,1,2,1500);
INSERT INTO SUPPLIER_PRICING VALUES(2,3,5,30000);
INSERT INTO SUPPLIER_PRICING VALUES(3,5,1,3000);
INSERT INTO SUPPLIER_PRICING VALUES(4,2,3,2500);
INSERT INTO SUPPLIER_PRICING VALUES(5,4,1,1000);
INSERT INTO SUPPLIER_PRICING VALUES(6,12,2,780);
INSERT INTO SUPPLIER_PRICING VALUES(7,12,4,789);
INSERT INTO SUPPLIER_PRICING VALUES(8,3,1,31000);
INSERT INTO SUPPLIER_PRICING VALUES(9,1,5,1450);
INSERT INTO SUPPLIER_PRICING VALUES(10,4,2,999);
INSERT INTO SUPPLIER_PRICING VALUES(11,7,3,549);
INSERT INTO SUPPLIER_PRICING VALUES(12,7,4,529);
INSERT INTO SUPPLIER_PRICING VALUES(13,6,2,105);
INSERT INTO SUPPLIER_PRICING VALUES(14,6,1,99);
INSERT INTO SUPPLIER_PRICING VALUES(15,2,5,2999);
INSERT INTO SUPPLIER_PRICING VALUES(16,5,2,2999);

INSERT INTO orders VALUES (101,1500,"2021-10-06",2,1);
INSERT INTO orders VALUES(102,1000,"2021-10-12",3,5);
INSERT INTO orders VALUES(103,30000,"2021-09-16",5,2);
INSERT INTO orders VALUES(104,1500,"2021-10-05",1,1);
INSERT INTO orders VALUES(105,3000,"2021-08-16",4,3);
INSERT INTO orders VALUES(106,1450,"2021-08-18",1,9);
INSERT INTO orders VALUES(107,789,"2021-09-01",3,7);
INSERT INTO orders VALUES(108,780,"2021-09-07",5,6);
INSERT INTO orders VALUES(109,3000,"2021-09-10",5,3);
INSERT INTO orders VALUES(110,2500,"2021-09-10",2,4);
INSERT INTO orders VALUES(111,1000,"2021-09-15",4,5);
INSERT INTO orders VALUES(112,789,"2021-09-16",4,7);
INSERT INTO orders VALUES(113,31000,"2021-09-16",1,8);
INSERT INTO orders VALUES(114,1000,"2021-09-16",3,5);
INSERT INTO orders VALUES(115,3000,"2021-09-16",5,3);
INSERT INTO orders VALUES(116,99,"2021-09-17",2,14);

INSERT INTO RATING VALUES(1,101,4);
INSERT INTO RATING VALUES(2,102,3);
INSERT INTO RATING VALUES(3,103,1);
INSERT INTO RATING VALUES(4,104,2);
INSERT INTO RATING VALUES(5,105,4);
INSERT INTO RATING VALUES(6,106,3);
INSERT INTO RATING VALUES(7,107,4);
INSERT INTO RATING VALUES(8,108,4);
INSERT INTO RATING VALUES(9,109,3);
INSERT INTO RATING VALUES(10,110,5);
INSERT INTO RATING VALUES(11,111,3);
INSERT INTO RATING VALUES(12,112,4);
INSERT INTO RATING VALUES(13,113,2);
INSERT INTO RATING VALUES(14,114,1);
INSERT INTO RATING VALUES(15,115,1);
INSERT INTO RATING VALUES(16,116,0);

-- Q3) Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.*/

select customer.cus_id,customer.cus_name,customer.cus_gender,orders.ord_amount from customer 
inner join (select ord_amount, cus_id from orders where ord_amount>=3000  group by cus_id) orders
on customer.cus_id = orders.cus_id;


-- 4)Display all the orders along with product name ordered by a customer having Customer_Id=2
select pro.pro_name,ord.* from orders ord
inner join  supplier_pricing sp on ord.pricing_id = sp.pricing_id
inner join product pro on sp.pro_id  = pro.pro_id
where ord.cus_id=2;


-- 5)	5)	Display the Supplier details who can supply more than one product.
select * from supplier 
where supp_id in(select supp_id from supplier_pricing group by supp_id having count(supp_id)>1);


-- 6)	Find the least expensive product from each category and print the table with category id, name, 
--      product name and price of the product
select ct.cat_id,ct.cat_name,pro.pro_name, min(sp.supp_price) price from category ct 
inner join product pro on ct.cat_id = pro.cat_id
inner join supplier_pricing sp on pro.pro_id = sp.pro_id
group by ct.cat_id;



-- 7)	Display the Id and Name of the Product ordered after “2021-10-05”.
SELECT pro.pro_id, pro.pro_name,ord.ord_date from product as pro
inner join supplier_pricing as sp on pro.pro_id = sp.pro_id
inner join orders as ord on sp.pricing_id = ord.pricing_id where ord_date > '2021-10-05';


-- 8)	Display customer name and gender whose names start or end with character 'A'.
select * from customer where cus_name like '%A%';

-- 9)	Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5,
--  print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.

select supp_id, supp_name, sum_of_rating/count_of_rating as rating ,
 case when rating = 5 then 'Excellent survice'
when rating = 4 then 'Good Survice'
when rating = 2 then 'Average survice'
else 'poor Survice'
end As 'Type of survice'
from (select sup.supp_id, supp_name, rat_ratstars rating , sum(rat_ratstars) sum_of_rating, count(rat_ratstars) count_of_rating 
from supplier sup 
inner join supplier_pricing sp
on sup.supp_id = sp.supp_id
inner join orders ors
on sp.pricing_id = ors.pricing_id
inner join rating rt
on ors.ord_id = rt.ord_id
group by sup.supp_id) a;





SELECT COUNT(customerDetails.CUS_ID) AS No_of_Customer,customerDetails.CUS_GENDER
FROM customer AS customerDetails  INNER JOIN
(SELECT orderDetails.ORD_Amount, orderDetails.CUS_ID FROM orders AS orderDetails WHERE orderDetails.ORD_AMOUNT >= 3000 group by orderDetails.CUS_ID) AS 
orderDetailsAtLeast ON customerDetails.CUS_ID = orderDetailsAtLeast.CUS_ID GROUP BY customerDetails.CUS_GENDER;








