--Customer Table PK(CID)   
CREATE TABLE customer( 
cid number PRIMARY KEY,
cname VARCHAR2(30)NOT NULL,
cadd VARCHAR2(30)NOT NULL,
c_contact number(10)NOT NULL,
c_creditdays NUMBER(5),
cj_date date,
sex VARCHAR2(10) );

INSERT INTO customer VALUES(1001,'Cyona blake','NEW YORK',1235684,20,'20-Jan-11','FEMALE');
INSERT INTO customer VALUES(1002,'JOHN SMITH','NEW JERSI',1341684,20,'21-Feb-11','MALE');
INSERT INTO customer VALUES(1003,'JORDAN WOOD','PRAG',1805184,20,'22-Mar-11','MALE');
INSERT INTO customer VALUES(1004,'CHRISTNA','MANHATTON',1125684,31,'23-Apr-13','FEMALE');
INSERT INTO customer VALUES(1005,'TOM HILL','LONDON',1239284,10,'25-Jun-15','MALE');
INSERT INTO customer VALUES(1006,'KAMILA JOSEF','PARISE',124568,9,'28-Jul-11','FEMALE');
INSERT INTO customer VALUES(1007,'ANDRU SYMON','TAXES',125654,15,'01-Apr-16','MALE');
INSERT INTO customer VALUES(1008,'SANJU SAMSUNG','NEW YORK',12346341,4,'20-Jan-16','MALE');
SELECT * FROM customer;

--Vendors Table PK(VID)
CREATE TABLE vendors(
vid number PRIMARY KEY,
vname varchar2(30)NOT NULL,
vadd varchar2(30)NOT NULL,
vcontact number(10)NOT NULL,
vcreditdays number(5),
vj_date date );

INSERT INTO vendors VALUES(2001,'KIRAN PATIL','PUNE',20535535,20,'20-Jan-10');
INSERT INTO vendors VALUES(2002,'PRAKASH JAIN','MUMBAI',2063564,10,'05-Nov-11');
INSERT INTO vendors VALUES(2003,'SWAPNIL THETE','NASHIK',25355352,15,'18-Mar-10');
INSERT INTO vendors VALUES(2004,'AMOL SHENDE','SATARA',23674776,18,'07-Apr-15');
INSERT INTO vendors VALUES(2005,'KARAN SINTRE','BULDHANA',256756,30,'22-Apr-09');
INSERT INTO vendors VALUES(2006,'RAM KULKARNI','OSMANABAD',20367454,21,'09-Jul-10');
SELECT * FROM vendors;

--Employee Table PK(EID)
CREATE TABLE employees(
eid number PRIMARY KEY,
ename varchar2(30)NOT NULL,
ejob varchar2(30)NOT NULL,
eadd varchar2(30)NOT NULL,
econtact number(10),
esal number(5),
edoj date,
edol date );

INSERT INTO employees VALUES(3001,'STEVEN KING','PAINTER','NEW YORK',10367454,1200,'09-Jul-10',NULL);
INSERT INTO employees VALUES(3002,'DAVID AUSTIN','FITTER','MAN HATON',10367434,1100,'19-Aug-10',NULL);
INSERT INTO employees VALUES(3003,'BRUCE ERNST','MECHANIC','NEW JERCY',10367264,2200,'08-Sep-10',NULL);
INSERT INTO employees VALUES(3004,'LUIS POPP','MECHANIC','NEW JERCY',10367264,1700,'19-Oct-09','06-Sep-10');
INSERT INTO employees VALUES(3005,'SHERI GOMES','FITTER','PARIS',10327264,1000,'19-Oct-09','01-Aug-10');
INSERT INTO employees VALUES(3000,'JAMES PHILLIP','FITTER','PARIS',10322264,NULL,'01-Jan-08',NULL);
SELECT * FROM employees;

--Sparepart Table PK(SPID)
CREATE TABLE sparepart(
spid number PRIMARY KEY,
spname varchar2(30) NOT NULL,
sprate number(4) NOT NULL,
spunit varchar2(10) );

INSERT INTO sparepart VALUES(4001,'TWO WHEELER TUBE',250,'NOS');
INSERT INTO sparepart VALUES(4002,'TWO WHEELER ENGINE OIL',400,'LTRS');
INSERT INTO sparepart VALUES(4003,'FOUR WHEELER ENGINE OIL',5000,'LTRS');
INSERT INTO sparepart VALUES(4004,'TWO WHEELER CARBORATOR',680,'NOS');
INSERT INTO sparepart VALUES(4005,'TWO WHEELER CLUTCH WIRE',129,'MTRS');
INSERT INTO sparepart VALUES(4006,'TWO WHEELER TAIIL LIGHT',100,'NOS');
INSERT INTO sparepart VALUES(4007,'TWO WHEELER INDICATORS',150,'NOS');
INSERT INTO sparepart VALUES(4008,'FOUR WHEELER GASKIT',1340,'NOS');
INSERT INTO sparepart VALUES(4009,'WHITE COLOUR',340,'LTRS');
INSERT INTO sparepart VALUES(4010,'BLACK COLOUR',240,'LTRS');
INSERT INTO sparepart VALUES(4011,'TWO WHEELER SIDE MIRROR',250,'NOS');
INSERT INTO sparepart VALUES(4012,'FOUR WHEELER SIDE MIRROR',450,'NOS');
INSERT INTO sparepart VALUES(4013,'TWO WHEELER SHOCKUP',1320,'PAIR');
INSERT INTO sparepart VALUES(4014,'FOUR WHEELER BUMPER',6000,'NOS');
INSERT INTO sparepart VALUES(4015,'FOUR WHEELER FRONT GLASS',7000,'PCS');
SELECT * FROM sparepart;

--Purchase Table PK(PID),FK(VID),FK(SPID),FK(eid or RCV_eid) 
CREATE TABLE purchase(
pid number PRIMARY KEY,
vid number(5)NOT NULL,
spid number(5)NOT NULL,
pqty number(5),
sprate number(5),
spgst float,
pdate date,
trancost number(7),
total float,
eid number(5),
FOREIGN KEY(vid) REFERENCES vendors(vid) ON DELETE CASCADE,
FOREIGN KEY(spid) REFERENCES sparepart(spid) ON DELETE CASCADE,
FOREIGN KEY(eid) REFERENCES employees(eid) ON DELETE CASCADE
);
drop table purchase
INSERT INTO purchase VALUES(5001,2001,4001,10,250,350,'01-Jan-11',1300,4150,3001);
INSERT INTO purchase VALUES(5002,2002,4002,4,400,288,'02-Mar-11',100,1988,3001);
INSERT INTO purchase VALUES(5003,2003,4004,8,680,761.6,'12-Jun-11',50,6251.6,3003);
INSERT INTO purchase VALUES(5004,2004,4005,10,129,154.8,'22-Aug-11',125,1569.8,3004);
INSERT INTO purchase VALUES(5005,2005,4006,20,100,300,'07-Sep-11',20,2320,3003);
INSERT INTO purchase VALUES(5006,2006,4007,30,150,630,'12-Oct-11',60,5190,3000);
INSERT INTO purchase VALUES(5007,2001,4003,20,5000,14000,'07-Sep-11',1000,115000,3000);
INSERT INTO purchase VALUES(5008,2006,4005,1,129,15.48,'12-Oct-11',50,194.48,3005);
INSERT INTO purchase VALUES(5009,2006,4005,1,129,15.48,'15-Oct-11',50,194.48,3005);
INSERT INTO purchase VALUES(5010,2006,4009,5,340,238,'20-Oct-11',0,2938,3005);
SELECT * FROM purchase;

--SER_DET Table PK(SID),FK(cid), FK(EID) ,FK(SPID)
CREATE TABLE ser_det(
sid number PRIMARY KEY,
cid number(5) NOT NULL,
eid number(5) NOT NULL,
spid number(5) NOT NULL,
typ_veh varchar2(30),
veh_no varchar2(30),
typ_ser varchar2(30),
ser_date date,
qty number(3,2),
sp_rate number(5),
sp_amt number(5),
sp_g number(5),
ser_amt number(5),
comm number(5),
total number(5) ,
FOREIGN KEY(cid) REFERENCES customer(cid) ON DELETE CASCADE,
FOREIGN KEY(eid) REFERENCES employees(eid) ON DELETE CASCADE,
FOREIGN KEY(spid) REFERENCES sparepart(spid) ON DELETE CASCADE
);

INSERT INTO ser_det VALUES(6001,1001,3001,4001,'TWO WHEELER','MH15CA3228','TUBE DAMAGED','02-Jan-11',1,250,250,35,50,0,335);
INSERT INTO ser_det VALUES(6002,1002,3002,4002,'TWO WHEELER','MH-16U5713','FULL SERVICING','04-Mar-11',1,400,400,52,300,50,752);
INSERT INTO ser_det VALUES(6003,1003,3004,4005,'TWO WHEELER','MH12PQ1313','CLUCH WIRE','22-Aug-11',1,129,129,0,10,0,139);
INSERT INTO ser_det VALUES(6004,1002,3002,4002,'TWO WHEELER','MH-16U5713','FULL SERVICING','05-May-11',1,400,400,52,300,50,752);
INSERT INTO ser_det VALUES(6005,1004,3001,4009,'TWO WHEELER','MH-14PA335','COLOR','21-Oct-11',2.5,340,850,119,500,150,1469);
INSERT INTO ser_det VALUES(6006,1006,3001,4009,'TWO WHEELER','MH-12WE334','COLOR','01-Dec-11',2.5,340,850,119,500,150,1469);
INSERT INTO ser_det VALUES(6007,1007,3001,4001,'FOUR WHEELER','MH17BB1345','TUBE DAMAGED','01-Jan-12',1,250,250,35,150,0,435);
INSERT INTO ser_det VALUES(6008,1007,3001,4001,'FOUR WHEELER','MH17BB1345','TUBE DAMAGED','01-Jan-12',1,250,250,35,150,0,435);
INSERT INTO ser_det VALUES(6009,1007,3001,4001,'FOUR WHEELER','MH17BB1345','TUBE DAMAGED','01-Jan-12',1,250,250,35,150,0,435);
SELECT * FROM ser_det;

--Q.1 List all the customers serviced.
SELECT DISTINCT c.cid,c.cname,s.sid 
FROM customer c 
INNER JOIN ser_det s
ON c.cid=s.cid;

--Q.2 Customers who are not serviced.
SELECT c.cid,c.cname,s.sid 
FROM customer c 
LEFT JOIN ser_det s
ON c.cid=s.cid
WHERE s.sid IS NULL;

--Q.3 Employees who have not received the commission.
SELECT e.eid,e.ename,s.sid,s.comm 
FROM employees e
LEFT JOIN ser_det s
ON e.eid=s.eid
WHERE s.comm IS NULL;

--Q.4 Name the employee who have maximum Commission.
SELECT DISTINCT e.ename,s.comm
FROM employees e
INNER JOIN ser_det s
ON e.eid=s.eid
WHERE s.comm=(SELECT MAX(comm) FROM ser_det);

--Q.5 Show employee name and minimum commission amount received by an employee.
SELECT DISTINCT e.ename,s.comm
FROM employees e
INNER JOIN ser_det s
ON e.eid=s.eid
WHERE s.comm=(SELECT MIN(comm) FROM ser_det);

--Q.6 Display the Middle record from any table.
SELECT * FROM (
    SELECT e.*,ROW_NUMBER() OVER (ORDER BY eid) AS rn,
    COUNT(*) OVER () AS total_rows
    FROM employees e
) WHERE rn = CEIL(total_rows / 2);

--Q.7 Display last 4 records of any table.
SELECT * FROM (
       SELECT e.*,ROW_NUMBER() OVER(ORDER BY eid DESC) AS rn 
       from employees e
) WHERE rn<=4 ORDER BY eid;
---
SELECT * FROM employees WHERE ROWID IN (
    SELECT ROWID FROM (
        SELECT ROWID FROM employees ORDER BY eid DESC
    )WHERE ROWNUM <= 4
)ORDER BY eid;

--Q.8 Count the number of records without count function from any table.
SELECT MAX(rn) AS no_of_records FROM (
       SELECT ROW_NUMBER() OVER(ORDER BY eid) AS rn from employees 
);
---
SELECT SUM(1) AS total_records FROM employee;

--Q.9 Delete duplicate records from "Ser_det" table on cid.(note Please rollback after execution).
SELECT * FROM Ser_det WHERE ROWID NOT IN (
    SELECT MAX(ROWID) FROM Ser_det GROUP BY cid
); --also done using MIN()
---
WITH cte AS(SELECT s.*,ROW_NUMBER() OVER(PARTITION BY cid ORDER BY cid) AS rn FROM Ser_det s)
SELECT * FROM cte WHERE rn>1;
---
SELECT cid FROM ser_det
GROUP BY cid
HAVING COUNT(*)>1;

--Q.10 Show the name of Customer who have paid maximum amount 
SELECT c.cname,s.total
FROM customer c
INNER JOIN ser_det s
ON c.cid=s.cid
WHERE s.total=(SELECT MAX(total) FROM ser_det);

SELECT * FROM CUSTOMER;

--Q.11 Display Employees who are not currently working.
SELECT e.eid,e.ename,s.eid 
FROM employees e LEFT JOIN ser_det s
ON e.eid=s.eid
WHERE s.eid IS NULL;

SELECT * FROM ser_det;

--Q.12 How many customers serviced their two wheelers.
SELECT COUNT(c.cid) AS cust_count
FROM customer c
RIGHT JOIN ser_det s
ON c.cid=s.cid
WHERE typ_veh='TWO WHEELER';

--Q.13 List the Purchased Items which are used for Customer Service with Unit of that Item.
SELECT sp.spid,sp.spname,sp.spunit,s.sid
FROM sparepart sp
INNER JOIN purchase p
ON sp.spid=p.spid
INNER JOIN ser_det s
ON p.spid=s.spid;

--Q.14 Customers who have Colored their vehicles.
SELECT c.cid,c.cname,c.cadd,s.sid,s.typ_ser
FROM customer c
RIGHT JOIN ser_det s
ON c.cid=s.cid
WHERE typ_ser='COLOR';

--Q.15 Find the annual income of each employee inclusive of Commission
SELECT e.eid, e.ename, e.ejob, e.esal,SUM(s.comm) AS comm,
       (e.esal * 12) + SUM(s.comm) AS annual_sal
FROM employees e INNER JOIN ser_det s
ON e.eid = s.eid
GROUP BY e.eid, e.ename, e.ejob, e.esal,s.comm;  --sum() because employee take more than 1 service

--**Q.16 Vendor Names who provides the engine oil.
SELECT DISTINCT v.vname,s.spname
FROM vendors v INNER JOIN purchase p 
ON v.vid = p.vid
INNER JOIN sparepart s 
ON p.spid = s.spid
WHERE s.spname LIKE '%ENGINE OIL%';
---
SELECT vname FROM vendors WHERE vid IN (
    SELECT vid FROM purchase WHERE spid IN (
        SELECT spid FROM sparepart WHERE spname LIKE '%ENGINE OIL%'
    )
);

--Q.17 Total Cost to purchase the Color and name the color purchased.
SELECT sp.spname AS color_name,SUM(s.total) AS total_cost
FROM purchase p
INNER JOIN sparepart sp ON p.spid = sp.spid
RIGHT JOIN ser_det s ON sp.spid=s.spid
WHERE typ_ser='COLOR'
GROUP BY sp.spname;

--**Q.18 Purchased Items which are not used in "Ser_det".
SELECT sp.spid,sp.spname AS item_name
FROM sparepart sp 
INNER JOIN purchase p ON sp.spid=p.spid 
LEFT JOIN ser_det s ON p.spid=s.spid
WHERE s.spid IS NULL;

--Q.19 Spare Parts Not Purchased but existing in Sparepart
SELECT sp.spid,sp.spname,p.spid 
FROM sparepart sp 
LEFT JOIN purchase p ON sp.spid=p.spid
WHERE p.spid IS NULL;

--Q.20 Calculate the Profit/Loss of the Firm. consider one month salary of each employee for Calculation.
SELECT
  (SELECT SUM(total) FROM ser_det) AS revenue,
  (SELECT SUM(total) FROM purchase) AS purchase_cost,
  (SELECT SUM(esal) FROM employees) AS salary_expense,
  ( (SELECT SUM(total) FROM ser_det) 
    - ( (SELECT SUM(total) FROM purchase) + (SELECT SUM(esal) FROM employees) )
  ) AS profit_or_loss
FROM dual;
---
SELECT
    (SELECT SUM(total) FROM ser_det) AS revenue,
    (SELECT SUM(total) FROM purchase) AS purchase_cost,
    (SELECT SUM(esal) FROM employees) AS salary_expense,
    ( (SELECT SUM(total) FROM ser_det) 
      - ( (SELECT SUM(total) FROM purchase) + (SELECT SUM(esal) FROM employees) ) 
    ) AS profit_or_loss
FROM ser_det
WHERE ROWNUM=1;

--Q.21 Specify the names of customers who have serviced their vehicles more than one time.
SELECT c.cname,COUNT(s.cid) no_of_time
FROM customer c
RIGHT JOIN ser_det s
ON c.cid=s.cid
GROUP BY c.cname
HAVING COUNT(s.cid)>1;

--Q.22 List the Items purchased from vendors locatio-nwise.
SELECT s.spname,v.vname,v.vadd
FROM vendors v
INNER JOIN purchase p
ON v.vid=p.vid
INNER JOIN sparepart s
ON p.spid=s.spid
ORDER BY v.vadd, s.spname;

--Q.23 Display count of two wheeler and four wheeler from ser_details
SELECT typ_veh,count(typ_veh) FROM ser_det
GROUP BY typ_veh;

--**Q.24 Display name of customers who paid highest SPGST and for which item 
SELECT c.cname,sp.spname,p.spgst
FROM purchase p
INNER JOIN sparepart sp
ON p.spid=sp.spid 
LEFT JOIN ser_det s
ON sp.spid=s.spid 
LEFT JOIN customer c
ON s.cid=c.cid
WHERE p.spgst = (SELECT MAX(spgst) FROM purchase);

--Q.25 Display vendors name who have charged highest SPGST rate for which item
SELECT v.vname,sp.spname,p.spgst
FROM vendors v
INNER JOIN purchase p
ON v.vid=p.vid
INNER JOIN sparepart sp
ON p.spid=sp.spid 
WHERE p.spgst = (SELECT MAX(spgst) FROM purchase);

--Q.26   list name of item and employee name who have received item 
SELECT sp.spname AS item_name, e.ename AS employee_name
FROM sparepart sp
INNER JOIN purchase p
    ON sp.spid = p.spid
INNER JOIN employees e
    ON p.eid = e.eid;
    
--Q.27 Display the Name and Vehicle Number of Customer who serviced his vehicle, And Name the Item used for Service, 
--And specify the purchase date of that Item with his vendor and Item Unit and Location, And employee Name who serviced the vehicle. 
--for Vehicle NUMBER "MH-14PA335".
SELECT c.cname AS customer_name,s.veh_no AS vehicle_number,sp.spname AS item_used,p.pdate AS purchase_date,
v.vname AS vendor_name,v.vadd AS item_location,sp.spunit AS item_unit,e.ename AS serviced_by
FROM employees e INNER JOIN purchase p
ON e.eid=p.eid
INNER JOIN sparepart sp
ON p.spid=sp.spid
INNER JOIN ser_det s
ON sp.spid=s.spid
INNER JOIN customer c
ON s.cid=c.cid
INNER JOIN vendors v
ON v.vid=p.vid
WHERE s.veh_no='MH-14PA335';

--Q.28 who belong this vehicle  MH-14PA335" Display the customer name 
SELECT c.cname,s.veh_no
FROM customer c INNER JOIN ser_det s
ON c.cid=s.cid
WHERE s.veh_no='MH-14PA335';

--Q.29 Display the name of customer who belongs to New York and when he /she service their vehicle on which date    
SELECT c.cname,s.veh_no,s.ser_date,c.cadd
FROM customer c INNER JOIN ser_det s
ON c.cid=s.cid
WHERE c.cadd='NEW YORK';

--Q.30 from whom we have purchased items having maximum cost?
SELECT v.vname,sp.spname,MAX(p.total) OVER(PARTITION BY v.vname) AS max_cost
FROM vendors v INNER JOIN purchase p
ON v.vid=p.vid
INNER JOIN sparepart sp
ON p.spid=sp.spid;
---
SELECT v.vname,sp.spname,MAX(p.total) AS max_cost
FROM vendors v INNER JOIN purchase p
ON v.vid=p.vid
INNER JOIN sparepart sp
ON p.spid=sp.spid
GROUP BY v.vname,sp.spname;

--Q.31 Display the names of employees who are not working as Mechanic and that employee done services   .
SELECT DISTINCT e.ename,e.ejob
FROM employees e INNER JOIN ser_det s
ON e.eid=s.eid
WHERE e.ejob<>'MECHANIC';
---
SELECT ename,ejob FROM employees e WHERE ejob<>'MECHANIC' AND 
EXISTS(SELECT 1 FROM ser_det s WHERE e.eid=s.eid)  

--Q.32 Display the various jobs along with total number of employees in each job. The output should contain only those jobs with more than two employees.
SELECT ejob,COUNT(*) AS no_of_emp FROM employees GROUP BY ejob HAVING COUNT(*)>2;

--Q.33 ***Display the details of employees who done service  and give them rank according to their no. of services .
-- only employees who have done at least one service
SELECT t.*,DENSE_RANK() OVER(ORDER BY no_of_ser DESC) AS rnk_ser FROM(
SELECT e.eid,e.ename,e.ejob,e.eadd,(SELECT COUNT(eid) FROM ser_det s WHERE e.eid=s.eid) AS no_of_ser FROM employees e )t
WHERE t.no_of_ser > 0;
---
SELECT e.eid,e.ename,e.ejob,e.eadd,
COUNT(s.eid) AS no_of_ser,
DENSE_RANK() OVER (ORDER BY COUNT(s.eid) DESC) AS rnk_ser
FROM employees e INNER JOIN ser_det s ON e.eid = s.eid        
GROUP BY e.eid, e.ename, e.ejob, e.eadd
ORDER BY rnk_ser;

--Q.34 Display those employees who are working as Painter and fitter and who provide service and total count of service done by fitter and painter  
SELECT e.eid, e.ename, e.ejob, COUNT(s.sid) AS total_services
FROM employees e
INNER JOIN ser_det s
    ON e.eid = s.eid
WHERE e.ejob IN ('PAINTER', 'FITTER')
GROUP BY e.eid, e.ename, e.ejob;
---
SELECT ename,ejob,(SELECT COUNT(eid) FROM ser_det s WHERE e.eid=s.eid) AS total_count 
FROM employees e WHERE ejob IN('PAINTER','FITTER') AND 
EXISTS(SELECT 1 FROM ser_det s WHERE e.eid=s.eid);

--Q.35 Display employee salary and as per highest  salary provide Grade to employee 
SELECT eid,ename,esal,
CASE 
  WHEN esal > 2000 THEN 'A'
  WHEN esal BETWEEN 1000 AND 2000 THEN 'B'
  ELSE 'C'
END AS grade_sal
FROM employees;

--Q.36  display the 4th record of emp table without using group by and rowid
SELECT eid,rnk FROM(
SELECT eid,ROW_NUMBER() OVER(ORDER BY eid) AS rnk FROM employees
) WHERE rnk<=4;

--Q.37 Provide a commission 100 to employees who are not earning any commission.
UPDATE ser_det
SET commission = 100
WHERE commission IS NULL OR commission = 0;

--Q.38 write a query that totals no. of services for each day and place the results in descending order
SELECT ser_date,COUNT(sid) AS total_services
FROM ser_det 
GROUP BY ser_date
ORDER BY total_services DESC;
    
--Q.39 Display the service details of those customer who belong from same city 
select s.* 
FROM ser_det s INNER JOIN customer c 
ON s.cid=c.cid 
WHERE cadd IN(SELECT cadd FROM customer GROUP BY cadd HAVING COUNT(*)>1 );

--*Q.40 write a query join customers table to itself to find all pairs of customers service by a single employee
SELECT c1.cname AS customer1, c2.cname AS customer2,s1.eid
FROM ser_det s1 INNER JOIN ser_det s2 
ON s1.eid = s2.eid AND s1.cid < s2.cid
INNER JOIN customer c1 ON s1.cid = c1.cid
INNER JOIN customer c2 ON s2.cid = c2.cid;

--Q.41 List each service number follow by name of the customer who made  that service
SELECT s.sid,c.cname
FROM customer c INNER JOIN ser_det s
ON c.cid=s.cid; 

--Q.42 Write a query to get details of employee and provide rating on basis of  maximum services provide by employee  .Note (rating should be like A,B,C,D)
SELECT e.eid, e.ename, e.ejob, e.esal,
       COUNT(s.sid) AS no_of_services,
       CASE 
           WHEN COUNT(s.sid) >= 5 THEN 'A'
           WHEN COUNT(s.sid) >= 3 THEN 'B'
           WHEN COUNT(s.sid) >= 2 THEN 'C'
           ELSE 'D'
       END AS rating
FROM employees e INNER JOIN ser_det s
ON e.eid = s.eid
GROUP BY e.eid, e.ename, e.ejob, e.esal;

--***Q.43 Write a query to get maximum service amount of each customer with their customer details ?
SELECT c.*,(SELECT Max(s.sp_amt)FROM ser_det s WHERE s.cid = c.cid ) AS max_amt
FROM customer c;
--
SELECT c.*, s.sp_amt
FROM customer c INNER JOIN ser_det s
ON c.cid = s.cid
WHERE s.sp_amt = (SELECT MAX(sp_amt) FROM ser_det WHERE cid = c.cid);
---
SELECT c.*, s.max_amt 
FROM customer c INNER JOIN (SELECT cid, MAX(sp_amt) AS max_amt FROM ser_det GROUP BY cid) s
ON c.cid = s.cid;


--***Q.44 Get the details of customers with his total no of services ?
SELECT c.*,(SELECT COUNT(*) FROM ser_det s WHERE s.cid = c.cid) AS total_services
FROM customer c;
---
SELECT c.cid, c.cname, c.cadd, COUNT(s.cid) AS total_services
FROM customer c LEFT JOIN ser_det s
ON c.cid = s.cid
GROUP BY c.cid, c.cname, c.cadd;

--Q.45 From which location sparpart purchased  with highest cost ?
SELECT v.vname, v.vadd, sp.spname, p.total
FROM vendors v
JOIN purchase p ON v.vid = p.vid
JOIN sparepart sp ON p.spid = sp.spid
WHERE p.total=(SELECT MAX(total) FROM purchase);

--Q.46 Get the details of employee with their service details who has salary is null
SELECT e.*,s.*
FROM employees e INNER JOIN ser_det s
ON e.eid=s.eid
WHERE e.esal IS NULL; --this is not ser_det but is in employee table

--Q.47 find the sum of purchase location wise 
SELECT v.vadd,SUM(P.TOTAL) AS total
FROM vendors v INNER JOIN purchase p
ON v.vid=p.vid
GROUP BY v.vadd;

--***Q.48 write a query sum of purchase amount in word location wise ?
SELECT v.vadd,ROUND(SUM(P.TOTAL)) AS total, TO_CHAR(TO_DATE(ROUND(SUM(P.TOTAL)),'J'), 'JSP') AS amount_in_words  
FROM vendors v INNER JOIN purchase p
ON v.vid=p.vid
GROUP BY v.vadd; 

--***Q.49 Has the customer who has spent the largest amount money has been give highest rating
SELECT t.*,DENSE_RANK() OVER(ORDER BY total_spent DESC) AS rating FROM (
    SELECT c.cid,c.cname,SUM(s.sp_amt) AS total_spent
    FROM customer c
    JOIN ser_det s ON c.cid = s.cid
    GROUP BY c.cid, c.cname
)t;

--***Q.50 select the total amount in service for each customer for which the total is greater than the amount of the largest service amount in the table
SELECT c.cname,SUM(s.sp_amt) AS total_amt,MAX(s.sp_amt) AS max_amt
FROM customer c INNER JOIN ser_det s 
ON c.cid = s.cid
GROUP BY c.cid, c.cname
HAVING SUM(s.sp_amt)> (SELECT MAX(sp_amt) FROM ser_det);
    
--Q.51  List the customer name and sparepart name used for their vehicle and  vehicle type
SELECT c.cname,sp.spname,s.typ_veh
FROM customer c INNER JOIN ser_det s 
ON c.cid = s.cid
INNER JOIN sparepart sp
ON s.spid=sp.spid;

--Q.52 Write a query to get spname ,ename,cname quantity ,rate ,service amount for record exist in service table 
SELECT sp.spname,e.ename,c.cname,s.qty,s.sp_rate,s.sp_amt
FROM employees e INNER JOIN purchase p
ON e.eid=p.eid
INNER JOIN sparepart sp
ON p.spid=sp.spid
INNER JOIN ser_det s
ON sp.spid=s.spid
INNER JOIN customer c
ON s.cid=c.cid;

--Q.53 specify the vehicles owners who’s tube damaged.
SELECT c.cname, s.veh_no, s.typ_ser, s.typ_ser
FROM customer c
INNER JOIN ser_det s ON c.cid = s.cid
WHERE s.typ_ser = 'TUBE DAMAGED';

--Q.54 Specify the details who have taken full service.
SELECT c.*,s.typ_ser
FROM customer c
INNER JOIN ser_det s ON c.cid = s.cid
WHERE s.typ_ser = 'FULL SERVICING';

--Q.55 Select the employees who have not worked yet and left the job.
SELECT * FROM employees 
WHERE edoj IS NULL  -- never joined
AND edol IS NULL;   ---- has left the company
  
--Q.56  Select employee who have worked first ever.
SELECT * FROM employees
WHERE edoj = (SELECT MIN(edoj) FROM employees WHERE edoj IS NOT NULL);    ---First ever = earliest date = MIN(date)

--Q.57 Display all records falling in odd date
SELECT * FROM employees
WHERE MOD(TO_CHAR(edoj, 'DD'), 2) <> 0;

--Q.58 Display all records falling in even date
SELECT * FROM employees
WHERE MOD(TO_CHAR(edoj, 'DD'), 2) = 0;

--Q.59 Display the vendors whose material is not yet used.
SELECT v.vname,p.pid,sp.spname
FROM vendors v FULL JOIN purchase p
ON v.vid=p.vid
RIGHT JOIN sparepart sp
ON p.spid=sp.spid;
    
--Q.60 Difference between purchase date and used date of spare part.
select TRUNC(ABS(MONTHS_BETWEEN(p.pdate,s.ser_date))) AS diff_in_months
FROM purchase p INNER JOIN ser_det s
ON p.spid=s.spid;

-----------------------------------------------------------------------------------------------------------------------------------------------------
























