--Create above three tables and insert above mentioned data into respective tables.

CREATE TABLE salespeople(
snum number PRIMARY KEY,
sname varchar2(20),
city varchar2(20),
comm number(5,2)
);

INSERT INTO salespeople VALUES(1001 ,'Peel','London',.12);
INSERT INTO salespeople VALUES(1002,'Serres','San Jose',.13);
INSERT INTO salespeople VALUES(1004,'Monika','London',.11);
INSERT INTO salespeople VALUES(1007,'Rifkin',' Barcelona',.15);
INSERT INTO salespeople VALUES(1003,'Axelrod','New York',.10);
INSERT INTO salespeople VALUES(1005,'Franc','London',.26);
SELECT * FROM salespeople;

CREATE TABLE customers(
cnum number PRIMARY KEY,
cname varchar2(20),
city varchar2(20),
rating number(5),
snum number, 
FOREIGN KEY(snum) REFERENCES salespeople(snum) ON DELETE CASCADE
);

INSERT INTO customers VALUES(2001,'Hoffman','London',100,1001);
INSERT INTO customers VALUES(2002,'Giovanni','Rome',200,1003);
INSERT INTO customers VALUES(2003,'Liu','San Jose',200,1002);
INSERT INTO customers VALUES(2004,'Grass','Berlin',300,1002);
INSERT INTO customers VALUES(2006,'Clemens','London',100,1001);
INSERT INTO customers VALUES(2008,'Cisneros','San Jose',300,1007);
INSERT INTO customers VALUES(2007,'Pereira','Rome',100,1004);
SELECT * FROM customers;


CREATE TABLE orders(
onum number PRIMARY KEY, 
amt number(7,2), 
odate timestamp, 
cnum number,
snum number,
FOREIGN KEY(cnum) REFERENCES customers(cnum) ON DELETE CASCADE,
FOREIGN KEY(snum) REFERENCES salespeople(snum) ON DELETE CASCADE
); 

INSERT INTO orders VALUES(3001,18.69,TO_DATE('03-Oct-96 12:30', 'DD-MON-YY HH24:MI'),2008,1007);
INSERT INTO orders VALUES(3003,767.19,TO_DATE('03-Oct-96 13:45','DD-MON-YY HH24:MI'),2001,1001);
INSERT INTO orders VALUES(3002,1900.10,TO_DATE('03-Oct-96 12:05','DD-MON-YY HH24:MI'),2007,1004);
INSERT INTO orders VALUES(3005,5160.45,TO_DATE('03-Oct-96 14:00','DD-MON-YY HH24:MI'),2003,1002);
INSERT INTO orders VALUES(3006,1098.16,TO_DATE('03-Oct-96 13:37','DD-MON-YY HH24:MI'),2008,1007);
INSERT INTO orders VALUES(3009,1713.23,TO_DATE('04-Oct-96 15:21','DD-MON-YY HH24:MI'),2002,1003);
INSERT INTO orders VALUES(3007,75.75,TO_DATE('04-Oct-96 16:02','DD-MON-YY HH24:MI'),2002,1003);
INSERT INTO orders VALUES(3008,4723.00,TO_DATE('05-Oct-96 12:07','DD-MON-YY HH24:MI'),2006,1001);
INSERT INTO orders VALUES(3010,1309.95,TO_DATE('06-Oct-96 13:12','DD-MON-YY HH24:MI'),2004,1002);
INSERT INTO orders VALUES(3011,9891.88,TO_DATE('06-Oct-96 13:09','DD-MON-YY HH24:MI'),2006,1001);
INSERT INTO orders VALUES(3012,3455.78,TO_DATE('04-Oct-96 15:21','DD-MON-YY HH24:MI'),2002,1003);
INSERT INTO orders VALUES(3013,1245.98,TO_DATE('04-Oct-96 16:32','DD-MON-YY HH24:MI'),2002,1003);
INSERT INTO orders VALUES(3014,3721.53,TO_DATE('05-Oct-96 12:45','DD-MON-YY HH24:MI'),2006,1001);
INSERT INTO orders VALUES(3015,734.50,TO_DATE('06-Oct-96 13:16','DD-MON-YY HH24:MI'),2004,1002);
INSERT INTO orders VALUES(3016,1729.67,TO_DATE('06-Oct-96 13:07','DD-MON-YY HH24:MI'),2006,1001);
SELECT * FROM orders;


-------------------------------------------------------------------------------------------------------------------------
--1.  List all customers with a rating of 100.
SELECT cnum,cname,rating FROM customers WHERE rating=100;

--2.  Find all records in the Customer table with NULL values in the city column.
SELECT cnum, cname, city FROM customers WHERE city IS NULL;

--3.  Find the largest order taken by each salesperson on each date.
SELECT snum, odate, MAX(amt) AS largest_order FROM orders
GROUP BY snum, odate
ORDER BY snum, odate;

--4.  Arrange the Orders table by descending customer number.
SELECT * FROM orders ORDER BY cnum DESC;

--5.  Find which salespeople currently have orders in the Orders table.
SELECT DISTINCT snum FROM orders;
---
SELECT DISTINCT s.*
FROM salespeople s INNER JOIN orders o
ON s.snum = o.snum;
  
--6.  List names of all customers matched with the salespeople serving them.
SELECT c.cname 
FROM salespeople s INNER JOIN customers c 
ON s.snum=c.snum;

--7.  ***Find the names and numbers of all salespeople who had more than one customer.
SELECT s.snum,s.sname,COUNT(c.cnum) AS no_of_cust
FROM salespeople s INNER JOIN customers c 
ON s.snum=c.snum 
GROUP BY s.snum, s.sname
HAVING COUNT(c.cnum) > 1;

--8.  Count the orders of each of the salespeople and output the results in descending order.
SELECT s.snum,s.sname,COUNT(o.onum) AS no_od_ord
FROM salespeople s INNER JOIN orders o 
ON s.snum=o.snum 
GROUP BY s.snum, s.sname
ORDER BY COUNT(o.onum) DESC;

--9.  ***List the Customer table if and only if one or more of the customers in the Customer tables are located in San Jose.
SELECT * FROM customers
WHERE EXISTS (SELECT 1 FROM customers WHERE city = 'San Jose');

--10. Match salespeople to customers according to what city they lived in.
SELECT c.cnum,c.cname,c.city,s.snum,s.sname
FROM salespeople s INNER JOIN customers c 
ON s.snum=c.snum; 

--11. Find the largest order taken by each salesperson.
SELECT snum,MAX(amt) AS LargestOrder FROM Orders GROUP BY snum; 
---
SELECT s.snum,s.sname,MAX(o.amt) AS max_amt
FROM salespeople s INNER JOIN orders o 
ON s.snum=o.snum 
GROUP BY s.snum, s.sname;

--12. Find customers in San Jose who has a rating above 200.
SELECT cnum,cname,city,rating FROM customers WHERE city='San Jose' AND rating > 200;

--13. List the names and commissions of all salespeople in London.
SELECT snum,sname,comm,city FROM salespeople WHERE city='London';

--14. List all the orders of salesperson Monika from the Orders table.
SELECT o.onum,o.amt,o.odate
FROM salespeople s INNER JOIN orders o
ON s.snum=o.snum
WHERE s.sname='Monika';

--15. ***Find all customers with orders on October 3.
SELECT c.cnum,c.cname,o.odate
FROM customers c INNER JOIN orders o
ON c.cnum=o.cnum
WHERE TRUNC(o.odate) = TO_DATE('03-OCT-96','DD-MON-YY');

--16. Give the sums of the amounts from the orders table, grouped by date, 
SELECT TRUNC(odate) AS order_date,SUM(amt) AS sum_amt 
FROM orders 
GROUP BY odate;

--17. Eliminating all those dates where the SUM was not at least 2000.00 above the MAX amount.
SELECT TRUNC(odate),SUM(amt) AS sum_amt,MAX(amt) AS max_amt FROM orders 
GROUP BY TRUNC(odate) 
HAVING SUM(amt)-MAX(amt)>=2000.00;

--18. *Select all orders that had amounts that were greater than at least one of the orders from October 6.
SELECT * FROM orders WHERE amt > ANY (SELECT amt FROM orders WHERE TRUNC(odate) = TO_DATE('06-OCT-96','DD-MON-YY'));

--19. Write a query that uses the EXISTS operator to extract all salespeople who have customers with a rating of 300.
SELECT s.snum, s.sname FROM salespeople s
WHERE EXISTS ( 
      SELECT 1 FROM customers c
      WHERE c.snum = s.snum AND c.rating = 300
);

--20. ***Find all pairs of customers having the same rating.
SELECT c1.cnum AS Customer1,
       c1.cname AS Name1,
       c2.cnum AS Customer2,
       c2.cname AS Name2,
       c1.rating,c2.rating
FROM customers c1 INNER JOIN customers c2
ON c1.rating = c2.rating      
AND c1.cnum < c2.cnum;  

--21. ***Find all customers with CNUM, 1000 above the SNUM of Serres.
SELECT * FROM customers WHERE cnum = 1000 + (SELECT snum FROM salespeople WHERE sname = 'Serres');

--22. Give the salespeople’s commissions as percentage instead of decimal numbers.
SELECT sname, comm,comm * 100 AS comm_per
FROM Salespeople;

--23. Find the largest order taken by each salesperson on each date, eliminating those MAX orders, which are less than $3000.00 in value.
SELECT s.snum,TRUNC(o.odate) AS odate,MAX(o.amt) AS max_amt
FROM salespeople s INNER JOIN orders o
ON s.snum=o.snum
GROUP BY s.snum,TRUNC(o.odate)
HAVING MAX(o.amt)>=3000;

--24. List the largest orders on October 3, for each salesperson.
SELECT s.snum,MAX(o.amt) AS lar_ord
FROM salespeople s INNER JOIN orders o
ON s.snum=o.snum
WHERE TRUNC(o.odate)=TO_DATE('03-OCT-96','DD-MON-YY')
GROUP BY s.snum;

--25. Find all customers located in cities where Serres  (SNUM 1002) has customers.
SELECT c.cnum, c.cname, c.city, c.rating, s.snum, s.sname
FROM customers c INNER JOIN salespeople s 
ON c.snum = s.snum WHERE c.city IN (
    SELECT * FROM customers WHERE snum = 1002
);

--26. Select all customers with a rating above 200.00.
SELECT * FROM customers WHERE rating>200;

--27. Count the number of salespeople currently listing orders in the Orders table.
SELECT COUNT(DISTINCT snum) AS no_of_salespeople FROM orders;

--28. Write a query that produces all customers serviced by salespeople with a commission above 12%. 
--Output the customer’s name and the salesperson‘s rate of commission.
SELECT c.cname,s.comm
FROM customers c INNER JOIN salespeople s 
ON c.snum = s.snum
WHERE comm > 0.12;  --12/100=0.12

--29. Find salespeople who have multiple customers.
SELECT s.snum,s.sname,COUNT(c.snum)
FROM customers c INNER JOIN salespeople s 
ON c.snum = s.snum
GROUP BY s.snum,s.sname
HAVING COUNT(c.snum)>1;

--30. Find salespeople with customers located in their city.
SELECT DISTINCT s.snum,s.sname,c.cname
FROM customers c INNER JOIN salespeople s 
ON c.snum = s.snum
WHERE c.city=s.city;

--31. Find all salespeople whose name starts with ‘P’ and the fourth character is ‘I’.
SELECT * FROM salespeople WHERE sname LIKE 'P__i%';
---
SELECT * FROM salespeople WHERE sname LIKE 'P%' AND sname LIKE '___i%';

--32. Write a query that uses a sub query to obtain all orders for the customer named ‘Cisneros’. Assume you do not know his customer number.
SELECT * FROM orders WHERE cnum IN(
SELECT cnum FROM customers WHERE cname='Cisneros');

--33. Find the largest orders for ‘Serres’ and ‘Rifkin’.
SELECT s.sname,MAX(o.amt) AS max_amt
FROM salespeople s INNER JOIN orders o
ON s.snum=o.snum
WHERE s.sname IN('Serres','Rifkin')
GROUP BY s.sname;

--34. Extract the Salespeople table in the following order: SNUM, SNAME, COMMISSION, CITY.
SELECT snum,sname,comm,city FROM salespeople;

--35. Select all customers whose names fall in between ‘A’ and ‘G’ alphabetical range.
SELECT * FROM customers WHERE cname BETWEEN 'A' AND 'G';
---
SELECT cnum, cname FROM customers WHERE REGEXP_LIKE(cname, '^[A-G]');
---
SELECT cnum, cname FROM customers WHERE cname >= 'A' AND cname < 'H';

--36. Select all the possible combinations of customers that you can assign.
SELECT c1.cname AS customer1, c2.cname AS customer2
FROM customers c1 CROSS JOIN customers c2;

--***37. Select all orders that are greater than the average for October 4.
SELECT onum, amt FROM orders WHERE amt > 
                                       (SELECT AVG(amt) FROM orders) AND TRUNC(odate)=TO_DATE('04-OCT-96','DD-MON-YY');

--***38. Write a select command using a correlated sub query that selects the names and 
--numbers of all customers with ratings equal to the maximum for their city.
SELECT cnum,cname,city,rating FROM customers c1 
WHERE rating=(
          SELECT MAX(rating) FROM customers c2
          WHERE c2.city = c1.city  ---We compare the outer customer’s rating to the max rating in their city
 );
     
--39. Write a query that totals the orders for each day and places the results in descending order.
SELECT TRUNC(odate) AS order_date,COUNT(onum) AS no_of_ord
FROM orders
GROUP BY TRUNC(odate)
ORDER BY no_of_ord DESC;

--40. Write a select command that produces the rating followed by the name of each customer in San Jose.
SELECT rating, cname FROM customers
WHERE city = 'San Jose';

--***41. Find all orders with amounts smaller than any amount for a customer in San Jose.
SELECT * FROM orders WHERE amt < ANY (
    SELECT amt FROM orders o INNER JOIN customers c 
    ON o.cnum = c.cnum
    WHERE c.city = 'San Jose'
);

--42. ***Find all orders with above average amounts for their customers.
SELECT * FROM orders o WHERE amt >
(
    SELECT AVG(amt) FROM orders WHERE cnum = o.cnum
);

--43. Write a query that selects the highest rating in each city.
SELECT city,MAX(rating)
FROM customers 
GROUP BY city;

--44. ***Write a query that calculates the amount of the salesperson’s commission on order by a customer with a rating above 100.00.
SELECT o.onum,s.sname AS salesman_name,o.amt,s.comm,(o.amt * s.comm) AS commission_amount
FROM orders o INNER JOIN customers c
ON o.cnum = c.cnum
INNER JOIN salespeople s
ON o.snum = s.snum
WHERE c.rating > 100;

--45. Count the customers with rating above San Jose’s average.
SELECT COUNT(cnum)FROM customers WHERE rating > (
    SELECT AVG(rating) FROM customers WHERE city = 'San Jose'
);


--**46. Write a query that produces all pairs of salespeople with themselves as well as duplicate rows with the order reversed.
SELECT s1.sname AS salespeople1_name,s2.sname AS salespeople2_name 
FROM salespeople s1,salespeople s2;
SELECT S1.SNAME,S2.SNAME FROM SALESPEOPLE S1,SALESPEOPLE S2 WHERE S1.SNAME>S2.SNAME;
---
SELECT s1.sname AS salespeople1_name,s2.sname AS salespeople2_name 
FROM salespeople s1 CROSS JOIN salespeople s2;


--47. Find all salespeople that are located in either Barcelona or London.
SELECT * FROM salespeople WHERE city IN('Barcelona','London');
SELECT * FROM salespeople WHERE city='Barcelona' OR city='London';

--***48. Find all salespeople with only one customer.
SELECT * FROM salespeople WHERE snum IN (
SELECT snum,COUNT(snum) FROM customers GROUP BY snum HAVING COUNT(snum)=1);
---
SELECT s.* FROM salespeople s INNER JOIN (
       SELECT snum FROM customers GROUP BY snum HAVING COUNT(*) = 1
)c
ON s.snum=c.snum;

--49. Write a query that joins the Customer table to itself to find all pairs of customers served by a single salesperson.
SELECT c1.cnum,c1.cname,c2.cnum,c2.cname
FROM customers c1 INNER JOIN customers c2
ON c1.snum=c2.snum
AND c1.cnum < c2.cnum;  -- exclude self-pairs & avoid duplicate reversed pairs

--50. Write a query that will give you all orders for more than $1000.00.
SELECT * FROM orders WHERE amt> 1000;

--***51. Write a query that lists each order number followed by the name of the customer who made that order.
SELECT o.onum,c.cname
FROM customers c INNER JOIN orders o
ON c.cnum=o.cnum;
--
SELECT o1.onum,c.cname 
FROM customers c INNER JOIN orders o1 
ON c.cnum=o1.cnum 
WHERE EXISTS(SELECT 1 FROM orders o WHERE c.cnum=o.cnum);

--***52. Write 2 queries that select all salespeople (by name and number) who have customers in their cities who they do not service, 
--one using a join and one a correlated subquery. Which solution is more elegant?
SELECT DISTINCT s.snum,s.sname FROM salespeople s INNER JOIN customers c
ON s.city=c.city AND s.snum<>c.snum; --match the id in same city
---
select snum,sname from salespeople s where exists 
     (select 1 from customers c 
     where s.city = c.city and s.snum <>c.snum)

--***53. Write a query that selects all customers whose ratings are equal than ANY (in the SQL sense) of Serres.
SELECT * FROM customers WHERE rating IN(select rating FROM customers WHERE snum=(SELECT snum FROM salespeople WHERE sname='Serres'));
--
SELECT DISTINCT c1.* FROM customers c1 INNER JOIN customers c2
ON c1.rating = c2.rating
AND c2.snum = (SELECT snum FROM salespeople WHERE sname = 'Serres');

--54. Write2 queries that will produce all orders taken on October3 or October 4.
SELECT * FROM orders WHERE TRUNC(odate)=TO_DATE('03-OCT-96','DD-MON-YY') OR TRUNC(odate)=TO_DATE('04-OCT-96','DD-MON-YY');
--
SELECT * FROM orders WHERE TRUNC(odate) BETWEEN TO_DATE('03-OCT-96','DD-MON-YY') AND TO_DATE('04-OCT-96','DD-MON-YY');

--55. ***Write a query that produces all pairs of orders by a given customer. Name that customer and eliminate duplicates.
SELECT c.cname,o1.onum AS order1,o2.onum AS order2
FROM orders o1, orders o2, customers c
WHERE o1.cnum = o2.cnum  --link cust to cust
  AND o1.onum < o2.onum  -- remove self-pairs and reversed duplicates
  AND o1.cnum = c.cnum   -- link ord to cust
  AND c.cname = 'Giovanni'; -- filter for a specific customer
--
SELECT c.cname,o1.onum,o2.onum
FROM orders o1 INNER JOIN orders o2
ON o1.cnum=o2.cnum
AND o1.onum < o2.onum
INNER JOIN customers c
ON o1.cnum=c.cnum
WHERE c.cname='Giovanni';  -- replace Giovanni with the given customer
;

--***56. Find only those customers whose ratings are higher than every customer in Rome.
SELECT * FROM customers WHERE 
rating > (
       SELECT MAX(rating) from customers WHERE city='Rome'
);  --Keeps only customers whose rating is higher than that maximum

--57. Write a query on the customers table whose output will exclude all customers with a rating < = 100.00, unless they are located in Rome.
SELECT * FROM customers WHERE rating >=100 AND city='Rome';

--58. Find all rows from the Customer table for which the salesperson number is 1001.
SELECT * FROM customers WHERE snum=1001;

--59. Find the total amount in Orders for each salesperson for which this total is greater than the amount of the largest order in the table.
SELECT o.snum,(SELECT sname FROM salespeople WHERE snum=o.snum) AS sname,SUM(amt) AS ttl_amt,MAX(amt) AS lar_amt 
FROM orders o 
GROUP BY snum 
HAVING SUM(amt)>MAX(amt);

--60. Write a query that selects all orders that have Zeroes or NULL in the Amount field.
SELECT * FROM orders WHERE amt IS NULL; 

--61. ***Produce all combinations of salespeople and customer names such that the former precedes the latter alphabetically, 
--and the latter has a rating of less than 200.
SELECT s.sname,c.cname
FROM salespeople s, customers c
WHERE s.sname<c.cname  -- < means alphabetically comes before.
AND c.rating<200;

--62. ***List all salespeople’s names and the commission they have earned.
SELECT s.sname,SUM(o.amt * s.comm) AS commission_earned
FROM salespeople s INNER JOIN orders o
ON s.snum = o.snum
GROUP BY s.sname;

--63. Write a query that produces the names and cities of all customers with the same rating as Hoffman. 
--Write the query using Hoffman’s CNUM rather than his rating, so that it would still be usable if his rating changed.
SELECT cname,city,rating FROM customers WHERE rating IN(SELECT rating FROM customers WHERE cnum IN(SELECT cnum FROM customers WHERE cname = 'Hoffman'));

--***64.Find all salespeople for whom there are customers that follow them in alphabetical order.
SELECT s.sname,c.cname
FROM salespeople s
JOIN customers c
  ON s.snum = c.snum
WHERE s.sname < c.cname;

--***65. Write a query that produces the names and ratings of all customers of all who have above average orders.
SELECT DISTINCT c.cname, c.rating 
FROM customers c INNER JOIN orders o
ON c.cnum = o.cnum
WHERE o.amt > (SELECT AVG(amt) FROM orders);
---
SELECT cname,rating FROM customers WHERE cnum IN(
SELECT cnum FROM orders WHERE amt > (SELECT AVG(amt) FROM orders))

--66. Find the sum of all purchases from the Orders table.
SELECT SUM(amt) AS ttl_amt FROM orders;

--67. Write a select command that produces the order number, amount, and date for all rows in the Order table.
SELECT onum,amt,odate FROM orders;

--68. Count the number of not null rating fields in the Customer table including duplicates.
SELECT COUNT(rating) FROM customers WHERE rating IS NOT NULL;

--69. Write a query that gives the names of both the salesperson and the customer for each order after the order number.
SELECT o.onum,s.sname,c.cname
FROM salespeople s INNER JOIN customers c
ON s.snum=c.snum
INNER JOIN orders o
ON c.cnum=o.cnum
ORDER BY o.onum;
---
SELECT o.onum,s.sname,c.cname
FROM salespeople s,customers c,orders o
WHERE s.snum=c.snum
AND c.cnum=o.cnum
ORDER BY o.onum;

--***70. List the commissions of all salespeople servicing customers in London.
SELECT sname,comm FROM salespeople WHERE snum IN(SELECT snum FROM customers WHERE city='London');
--
SELECT DISTINCT s.sname,s.comm
FROM salespeople s INNER JOIN customers c
ON s.snum=c.snum
WHERE c.city='London';

--***71. Write a query using ANY or ALL that will find all salespeople who have no customers located in their city.
SELECT s.snum, s.sname FROM salespeople s WHERE s.city <> ALL (
    SELECT c.citY FROM customers c WHERE c.snum = s.snum
);
---
SELECT s.snum, s.sname FROM salespeople s WHERE NOT EXISTS (
    SELECT 1 FROM customers c WHERE c.snum = s.snum AND c.city = s.city --Customer city matches salesperson city.
);

--72. Write a query using the EXISTS operator that selects all salespeople with customers located in their cities who are not assigned to them.
SELECT s.snum, s.sname FROM salespeople s WHERE EXISTS (
    SELECT 1 FROM customers c WHERE c.snum <> s.snum AND c.city = s.city 
);
---
SELECT s.snum, s.sname, s.city FROM salespeople s WHERE EXISTS (
    SELECT 1 FROM customers c
    WHERE c.city = s.city      -- same city as salesperson
    AND c.snum <> s.snum     -- but not assigned to this salesperson same city
);

--73. Write a query that selects all customers serviced by Peel or Motika.
SELECT * FROM customers WHERE snum IN (SELECT snum FROM salespeople WHERE sname IN('Peel','Monika'));
---
SELECT c.*
FROM customers c
JOIN salespeople s ON c.snum = s.snum
WHERE sname IN('Peel','Monika');

--74. Count the number of salespeople registering orders for each day. 
--(If a salesperson has more than one order on a given day, he or she should be counted only once.).
SELECT TRUNC(odate) AS odate,COUNT(DISTINCT snum) AS no_of_salesp FROM orders GROUP by odate;
---
SELECT TRUNC(o.odate),COUNT(DISTINCT o.snum)
FROM orders o INNER JOIN salespeople s 
ON o.snum = s.snum
GROUP by o.odate;

--75. Find all orders attributed to salespeople in London.
SELECT * FROM orders WHERE snum IN(SELECT snum FROM salespeople WHERE city='London');
---
SELECT o.*
FROM orders o
JOIN salespeople s ON o.snum = s.snum
WHERE s.city = 'London';

--76. Find all orders by customers not located in the same cities as their salespeople.
SELECT o.*
FROM orders o, customers c, salespeople s
WHERE o.cnum=c.cnum
AND o.snum=s.snum
AND c.city<>s.city;
---
SELECT o.*
FROM orders o INNER JOIN customers c
ON o.cnum=c.cnum
INNER JOIN salespeople s
ON o.snum=s.snum
WHERE c.city<>s.city;

--77. Find all salespeople who have customers with more than one current order.
SELECT DISTINCT s.snum, s.sname FROM salespeople s WHERE s.snum IN (
    SELECT c.snum FROM customers c WHERE c.cnum IN (
        SELECT cnum FROM orders GROUP BY cnum HAVING COUNT(onum) > 1)
);

---
SELECT DISTINCT s.snum, s.sname
FROM salespeople s
INNER JOIN customers c ON s.snum = c.snum
INNER JOIN orders o ON c.cnum = o.cnum
GROUP BY s.snum, s.sname, c.cnum
HAVING COUNT(o.onum) > 1;

--78. Write a query that extracts from the Customer table every customer assigned to a salesperson 
--who currently has at least one other customer (besides the customer being selected) with orders in the Orders table.
SELECT DISTINCT c1.cnum, c1.cname, c1.snum
FROM customers c1 INNER JOIN customers c2 
    ON c1.snum = c2.snum       
    AND c1.cnum <> c2.cnum     
INNER JOIN orders o 
    ON c2.cnum = o.cnum;     
---
SELECT c.cnum, c.cname, c.snum FROM customers c
WHERE EXISTS (SELECT 1 FROM customers c2 INNER JOIN orders o2 ON c2.cnum = o2.cnum
              WHERE c2.snum = c.snum       
              AND c2.cnum <> c.cnum      
);


--79. Write a query that selects all customers whose name begins with ‘C’.
SELECT * FROM customers WHERE SUBSTR(cname,1,1)='C';
--- 
SELECT * FROM customers WHERE cname LIKE 'C%';

--80. Write a query on the Customers table that will find the highest rating in each city. Put the output in this form:  
--for the city (city) the highest rating is : (rating).
SELECT city AS for_the_city,MAX(rating)AS the_highest_rating_is FROM customers GROUP BY city;

--81. Write a query that will produce the Snum values of all salespeople with orders currently in the Orders table without any repeats.
SELECT DISTINCT  s.snum,s.sname,o.onum 
FROM salespeople s,orders o
WHERE s.snum=o.snum;
---
SELECT DISTINCT s.snum,s.sname,o.onum
FROM salespeople s
JOIN orders o ON s.snum = o.snum;

--82. Write a query that lists customers in descending order of rating. Output the rating field first, followed by the customers’ names and numbers.
SELECT rating,cnum,cname,city FROM customers ORDER BY rating DESC;

--83. Find the average commission for salespeople in London.
SELECT ROUND(AVG(comm),2) AS avg_comm FROM salespeople WHERE city='London';

--84. Find all orders credited to the same salesperson that services Hoffman.
SELECT o.*,s.sname
FROM salespeople s INNER JOIN orders o
ON s.snum=o.snum
INNER JOIN customers c
ON o.cnum=c.cnum
WHERE c.cname='Hoffman';
---
SELECT * FROM orders WHERE cnum IN(
SELECT c.cnum 
FROM customers c INNER JOIN salespeople s 
ON c.snum=s.snum 
WHERE cname='Hoffman');


--85. Find all salespeople whose commission is in between 0.10 and 0.12 both inclusive.
SELECT * FROM salespeople WHERE comm BETWEEN 0.10 AND 0.12;

--86. Write a query that will give you the names and cities of all salespeople in London with commission above 0.10
SELECT sname,city FROM salespeople WHERE city='London' AND comm>0.10;

--87. What will be the output from the following query? 
SELECT * FROM ORDERS WHERE (AMT < 1000 OR NOT (ODATE = 10/03/1996 AND CNUM > 2003));
                        --Inconsistent datatypes: expected TIMESTAMP got NUMBER
                        --SQL interprets 10/03/1996 as arithmetic expression
                        --Dates in SQL must be written using TO_DATE (or DATE literal) and include a format mask.
SELECT * FROM orders WHERE amt < 1000 OR NOT (odate = TO_DATE('03-OCT-1996', 'DD-MON-YYYY') AND cnum > 2003);
   
--88. Write a query that selects each customer’s smallest order.
SELECT c.cname,(SELECT MIN(o.amt) FROM orders o 
WHERE o.cnum = c.cnum) AS small_ord
FROM customers c;
---
SELECT c.cname, o.onum, o.amt AS small_ord 
FROM customers c INNER JOIN orders o 
ON c.cnum = o.cnum
JOIN (SELECT cnum, MIN(amt) AS min_amt FROM orders GROUP BY cnum) m 
ON o.cnum = m.cnum AND o.amt = m.min_amt;


--***89. Write a query that selects the first customer in alphabetical order whose name begins with ‘G’.
SELECT *
FROM (
    SELECT cname
    FROM customers
    WHERE cname LIKE 'G%'
    ORDER BY cname ASC
)
WHERE ROWNUM <= 1;

--90. Write a query that counts the number of different not NULL city values in the Customers table.
SELECT COUNT(DISTINCT city) AS num_cities FROM customers
WHERE city IS NOT NULL;

--91. Find the average amount from the Orders table.
SELECT ROUND(AVG(amt),2) AS avg_amt FROM orders

--92. What would be the output from the following query?
SELECT*FROM ORDERS WHERE NOT (Odate =10/03/1996 OR Snum>1006) AND amt. >=1500);
        --invalid user.table.colimn, table.column, or column specification
                           --Odate is a DATE/TIMESTAMP, so this causes an inconsistent datatype error.
                           --amt. → the dot is not valid unless it’s part of table.column.
                           --Extra closing parenthesis ) at the end.
SELECT * FROM orders WHERE NOT (odate = TO_DATE('03-OCT-1996','DD-MON-YYYY') OR snum > 1006) AND amt >= 1500;
  
--93. Find all customers who are not located in San Jose & whose rating is above 200.
SELECT * FROM customers WHERE city<>'San Jose' AND rating>200;

--94. Give a simpler way to write this query:
SELECT Snum, Sname, city, Comm FROM salespeople WHERE (Comm>0.12 and Comm <0.14);
SELECT Snum, Sname, city, Comm FROM salespeople WHERE Comm BETWEEN 0.12 AND 0.14;

--95. Evaluate the following query:
SELECT * FROM orders WHERE NOT ((Odate = 10/03/1996 AND Snum>1002) OR amt>2000);
                  --Inconsistent datatypes: expected TIMESTAMP got NUMBER
                  --Odate is a DATE/TIMESTAMP, so this causes an inconsistent datatype error.
SELECT * FROM orders WHERE NOT ((Odate = TO_DATE('03-OCT-1996','DD-MON-YYYY') AND snum > 1002) OR amt > 2000);

--96. Which salespeople attend to customers not in the city they have been assigned to?
SELECT s.sname,s.city,c.cname,c.city
FROM salespeople s,customers c
WHERE s.snum=c.snum
AND s.city<>c.city;

--97. Which salespeople get commission greater than 0.11 and serving customers rated less than 250?
SELECT DISTINCT s.sname 
FROM salespeople s INNER JOIN customers c 
ON s.snum=c.snum 
WHERE comm>0.11 AND c.rating<250;

--98. Which salespeople have been assigned to the same city but get different commission percentages?
SELECT s.sname, s.city, s.comm
FROM salespeople s, salespeople s1
WHERE s.city = s1.city
AND s.snum <> s1.snum
AND s.comm <> s1.comm;
---
SELECT s.sname, s.city, s.comm
FROM salespeople s CROSS JOIN salespeople s1
WHERE s.city = s1.city
AND s.snum <> s1.snum
AND s.comm <> s1.comm;

--99. Which salesperson has earned the most by way of commission?
SELECT * FROM (
    SELECT s.sname,ROUND(SUM(o.amt * s.comm),2) AS total_commission
    FROM salespeople s INNER JOIN orders o 
    ON s.snum = o.snum
    GROUP BY s.sname
    ORDER BY total_commission DESC
)WHERE ROWNUM = 1;

***--100.  Does the customer who has placed the maximum number of orders have the maximum rating?
SELECT c.cnum,COUNT(c.cnum) AS no_of_ord, MAX(c.rating) AS max_rating
FROM customers c INNER JOIN  orders o
ON c.cnum=o.cnum
GROUP BY c.cnum ORDER BY c.cnum;
---
SELECT o.cnum,o.order_count,c.max_rating FROM
    (SELECT cnum, COUNT(*) AS order_count FROM orders GROUP BY cnum) o
INNER JOIN
    (SELECT cnum, MAX(rating) AS max_rating FROM customers GROUP BY cnum) c
ON o.cnum = c.cnum ORDER BY c.cnum;

***--101.  Has the customer who has spent the largest amount of money been given the highest rating?
SELECT c.cnum,MAX(o.amt) AS max_amt, MAX(c.rating) AS max_rating
FROM customers c INNER JOIN  orders o
ON c.cnum=o.cnum
GROUP BY c.cnum
ORDER BY c.cnum;
---
SELECT o.cnum,o.max_amt,c.max_rating FROM
    (SELECT cnum, MAX(amt) AS max_amt FROM orders GROUP BY cnum) o
INNER JOIN
    (SELECT cnum, MAX(rating) AS max_rating FROM customers GROUP BY cnum) c
ON o.cnum = c.cnum ORDER BY c.cnum;

--102.  List all customers in descending order of customer rating.
SELECT * FROM customers ORDER BY rating DESC;

--103.  On which days has Hoffman placed orders?
SELECT o.odate,c.cname
FROM customers c INNER JOIN orders o
ON c.cnum=o.cnum
AND c.cname='Hoffman';
---
SELECT odate FROM orders WHERE cnum IN(select cnum FROM customers WHERE cname='Hoffman');

--***104.  Do all salespeople have different commissions?
SELECT
    CASE
        WHEN EXISTS (SELECT 1 FROM salespeople GROUP BY comm HAVING COUNT(*) > 1)
        THEN 'NO'
        ELSE 'YES'
    END AS result
    FROM dual;
---
SELECT 
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT comm) THEN 'Yes'
        ELSE 'No'
    END AS all_commissions_different
FROM salespeople;
---
SELECT sname,comm FROM salespeople;

--105.  Which salespeople have no orders between 10/03/1996 and 10/05/1996?
SELECT * FROM salespeople s
WHERE NOT EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.snum = s.snum
      AND o.odate BETWEEN TO_DATE('03-OCT-1996','DD-MON-YYYY') 
                     AND TO_DATE('05-OCT-1996','DD-MON-YYYY')
);
---
SELECT * FROM salespeople WHERE snum NOT IN(
SELECT snum FROM orders WHERE odate BETWEEN TO_DATE('03-OCT-1996','DD-MON-YYYY') 
                     AND TO_DATE('05-OCT-1996','DD-MON-YYYY') 
);

--106.  How many salespersons have succeeded in getting orders?
SELECT COUNT(snum) AS ttl_salespersons FROM salespeople WHERE snum IN(SELECT snum FROM orders);

--107.  How many customers have placed orders?
SELECT COUNT(cnum) AS ttl_customers FROM customers WHERE cnum IN(SELECT cnum FROM orders);

--108.  On which date has each salesperson booked an order of maximum value?
SELECT s.sname, o.odate, o.amt
FROM salespeople s INNER JOIN orders o 
ON s.snum = o.snum
WHERE o.amt = (SELECT MAX(o2.amt) FROM orders o2 WHERE o2.snum = s.snum);

--109.  Who is the most successful salesperson?
SELECT * FROM (
    SELECT s.sname,ROUND(SUM(o.amt * s.comm),2) AS total_commission
    FROM salespeople s INNER JOIN orders o 
    ON s.snum = o.snum
    GROUP BY s.sname
    ORDER BY total_commission DESC
)WHERE ROWNUM = 1;

--110.  Who is the worst customer with respect to the company?
SELECT * FROM(
SELECT c.cname, SUM(o.amt) AS total_spent
FROM customers c, orders o
WHERE c.cnum = o.cnum
GROUP BY c.cname
ORDER BY total_spent ASC
) WHERE ROWNUM = 1;

--***111.  Are all customers not having placed orders greater than 200 totally been serviced by salesperson Peel or Serres?
SELECT c.cnum,o.amt, s.sname
FROM customers c INNER JOIN orders o 
ON c.cnum = o.cnum
INNER JOIN salespeople s ON c.snum = s.snum; 
---
SELECT 
CASE 
  WHEN NOT EXISTS (SELECT 1 FROM customers c 
       INNER JOIN orders o ON c.cnum = o.cnum
       INNER JOIN salespeople s ON c.snum = s.snum
       WHERE o.amt <= 200 AND s.sname NOT IN ('Peel','Serres')
       )
  THEN 'Yes'
 ELSE 'No'
END AS all_serviced_by_peel_or_serres
FROM dual;

--112.  Which customers have the same rating?
SELECT c1.cname, c1.rating
FROM customers c1
JOIN customers c2
ON c1.rating = c2.rating
AND c1.cnum <> c2.cnum;

--113.  Find all orders greater than the average for October 4th.
SELECT * FROM orders WHERE amt > (
    SELECT AVG(amt) FROM orders WHERE TRUNC(odate) = TO_DATE('04-OCT-96','DD-MON-YY')
);


--**114.  Which customers have above average orders?
SELECT DISTINCT c.cname
FROM customers c INNER JOIN orders o
ON c.cnum=o.cnum
WHERE o.amt>(SELECT AVG(amt) FROM orders); 
---
SELECT cname FROM customers WHERE cnum IN(SELECT cnum FROM orders WHERE amt >(SELECT AVG(amt) FROM orders));


--**115.  List all customers with ratings above San Jose’s average.
SELECT cname,rating FROM customers WHERE rating>(SELECT AVG(rating) FROM customers WHERE city='San Jose');


--116.  Select the total amount in orders for each salesperson for which the total is greater than the amount of the largest order in the table.
SELECT snum,SUM(amt) AS ttl_amt FROM orders 
GROUP BY snum 
HAVING SUM(amt)>(SELECT MAX(amt) FROM orders);


--117.  Give names and numbers of all salesperson that have more than one customer.
SELECT snum,sname FROM salespeople WHERE snum IN(
SELECT snum FROM customers GROUP BY snum HAVING COUNT(snum)>1);


--***118.  Select all salesperson by name and numbers who have customers in their city whom they don’s the service.
SELECT s.snum,s.sname 
FROM salespeople s INNER JOIN customers c
ON c.city=s.city
AND s.snum<>c.snum;
---
SELECT s.snum, s.sname FROM salespeople s
WHERE EXISTS (
    SELECT 1 FROM customers c 
    WHERE c.city = s.city    
    AND c.snum <> s.snum   
);


--119.  Which customers’ rating should be lowered?
SELECT c.cnum, c.cname, c.rating,MAX(o.amt) AS max_order_amt
FROM customers c INNER JOIN orders o ON c.cnum = o.cnum
GROUP BY c.cnum, c.cname, c.rating
HAVING c.rating > MAX(o.amt);
---
SELECT c.cnum, c.cname, c.rating,AVG(o.amt) AS avg_order_amt
FROM customers c INNER JOIN orders o ON c.cnum = o.cnum
GROUP BY c.cnum, c.cname, c.rating
HAVING c.rating > AVG(o.amt);


--120.  Is there a case for assigning a salesperson to Berlin? --any Berlin customer has no assigned salesperson
SELECT CASE 
         WHEN EXISTS (
             SELECT 1 FROM customers WHERE city = 'Berlin' AND snum IS NULL
         ) 
         THEN 'Yes'
         ELSE 'No'
       END AS assign_needed
FROM dual;


--121.  Is there any evidence linking the performance of a salesperson to commission that he or she is being paid?
SELECT sname, comm, SUM(amt) AS total_sales, COUNT(o.snum) AS order_count
FROM salespeople s
JOIN orders o ON s.snum = o.snum
GROUP BY sname, comm
ORDER BY comm DESC;


--***122.  Dose the total amount in orders by customer in Rome and London exceeds the commission paid to salesperson in London and New York by more than 5 times?
SELECT 
CASE
  WHEN EXISTS(SELECT 1 FROM salespeople s INNER JOIN customers c
              ON s.snum=c.snum
              INNER JOIN orders o
              ON c.cnum=o.cnum
              WHERE c.city IN('Rome','London') AND s.city IN('New York','London')
              HAVING SUM(o.amt)>SUM(s.comm)*5
              )
              THEN 'YES'
  ELSE 'NO'
END AS more_than_5times
FROM dual;
---
SELECT 
     CASE
       WHEN (SELECT SUM(o.amt) FROM salespeople s INNER JOIN customers c
              ON s.snum=c.snum
              INNER JOIN orders o
              ON c.cnum=o.cnum
              WHERE c.city IN('Rome','London')
             )>
             (SELECT SUM(s.comm) FROM salespeople s INNER JOIN customers c
              ON s.snum=c.snum
              INNER JOIN orders o
              ON c.cnum=o.cnum
              WHERE s.city IN('New York','London')
             )*5
             THEN 'YES'
        ELSE 'NO'
       END AS more_than_5times
FROM dual;
       

--***123.  Which is the date, order number, amt and city for each salesperson (byname) for the maximum order he has obtained?
SELECT s.sname,o.odate,o.onum,o.amt,s.city
FROM salespeople s INNER JOIN orders o
ON s.snum=o.snum
WHERE o.amt= (SELECT MAX(o2.amt) FROM orders o2 WHERE o2.snum = o.snum);
---
SELECT s.sname,o.odate,o.onum,o.amt,s.city
FROM salespeople s INNER JOIN orders o
ON s.snum=o.snum
WHERE o.amt IN (SELECT MAX(amt) FROM orders GROUP BY snum);

--124.  Which salesperson(s) should be fired?
SELECT s.snum, s.sname, s.city, SUM(o.amt) AS total_sales
FROM salespeople s
LEFT JOIN orders o ON s.snum = o.snum
GROUP BY s.snum, s.sname, s.city
HAVING SUM(o.amt) < 1000 OR SUM(o.amt) IS NULL;

--125.  What is the total income for the company? 
SELECT SUM(amt) AS total_income FROM orders;

---------------------------------------------------------------------------------------------------------------------------------------------------------

  

