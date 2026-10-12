--Questions: 
--1.  Write create table syntax for employee table and Incentive table
CREATE TABLE employee(
emp_id number PRIMARY KEY,
first_name varchar2(30),
last_name varchar2(30),
salary number(10),
joining_date date,
department varchar(20)
);

CREATE TABLE incentives(
emp_ref_id number, -- PRIMARY KEY,
incentive_date date,
incentive_amount number(10),
FOREIGN KEY(emp_ref_id) REFERENCES employee(emp_id) ON DELETE CASCADE
);

--2.  Write syntax for insert data into table of employee table and Incentive table
INSERT INTO employee VALUES(1,'John','Abraham',1000000,'01-Jan-13','Banking');
INSERT INTO employee VALUES(2,'Michael','Clarke',800000,'01-Jan-13','Insurance');
INSERT INTO employee VALUES(3,'Roy','Thomas',700000,'01-Feb-13','Banking');
INSERT INTO employee VALUES(4,'Tom','Jose',600000,'01-Feb-13','Insurance');
INSERT INTO employee VALUES(5,'Jerry','Pinto',650000,'01-Feb-13','Insurance');
INSERT INTO employee VALUES(6,'Philip','Mathew',750000,'01-Jan-13','Services');

INSERT INTO incentives VALUES(1,'01-Feb-13',5000);
INSERT INTO incentives VALUES(2,'01-Feb-13',3000);
INSERT INTO incentives VALUES(3,'01-Feb-13',4000);
INSERT INTO incentives VALUES(1,'01-Jan-13',4500);
INSERT INTO incentives VALUES(2,'01-Jan-13',3500);

--3.  Get all employee details from the employee table
SELECT * FROM employee;

--4.  Get First_Name,Last_Name from employee table
SELECT first_name, last_name FROM employee;

--5.	Get First_Name from employee table using alias name  Employee Name 
SELECT first_name AS Employee_Name FROM employee;

--6.	Get First_Name from employee table in upper case
SELECT UPPER(first_name) FROM employee;

--7.	Select first 3 characters of FIRST_NAME from EMPLOYEE
SELECT SUBSTR(first_name,1,3) AS first_3char FROM employee;

--8.  Get position of 'o' in name 'John' from employee table
SELECT INSTR('John','o') AS Position FROM employee where first_name='John';
    
--9.  Get FIRST_NAME from employee table after removing white spaces from right side.
SELECT RTRIM(first_name) FROM employee;

--10. Get First_Name from employee table after replacing 'o' with '$'
SELECT REPLACE(first_name,'o','$') FROM employee;

--11. Get First_Name and Last_Name as single column from employee table separated by a '_'
SELECT first_name||'_'|| last_name AS full_name FROM employee;

--12. Get FIRST_NAME, Joiningyear, Joining Month and Joining Date from employee table
SELECT first_name,EXTRACT(YEAR FROM joining_date) AS Year,
                  EXTRACT(MONTH FROM joining_date) AS Month,
                  EXTRACT(DAY FROM joining_date) AS Day
FROM employee;
---
SELECT first_name,TO_CHAR(joining_date,'YYYY') AS Year,
                  TO_CHAR(joining_date,'MM') AS Month,
                  TO_CHAR(joining_date,'DD') AS Day
FROM employee;

--13. Get all employee details from the employee table order by First_Name Ascending
SELECT * FROM employee ORDER BY first_name ASC;

--14. Get all employee details from the employee table order by First_Name Ascending and Salary Descending?
SELECT * FROM employee ORDER BY first_name ASC, salary DESC;

--15. Get employee details from employee table whose employee name is  John 
SELECT * FROM employee WHERE first_name='John';

--16. Get employee details from employee table whose employee name are  John  and  Roy 
SELECT * FROM employee WHERE first_name IN('John','Roy');
SELECT * FROM employee WHERE first_name='John' OR first_name='Roy';

--17. Get employee details from employee table whose employee name are not  John  and  Roy .
SELECT * FROM employee WHERE first_name NOT IN('John','Roy');
SELECT * FROM employee WHERE first_name<>'John' OR first_name<>'Roy';

--18. Get employee details from employee table whose first name starts with 'J'.
SELECT * FROM employee WHERE first_name LIKE 'J%';
SELECT * FROM employee WHERE SUBSTR(first_name,1,1)='J';

--19. Get employee details from employee table whose first name contains 'o'.
SELECT * FROM employee WHERE first_name LIKE '%o%';
SELECT * FROM employee WHERE INSTR(first_name,'o')>0;

--20. Get employee details from employee table whose first name ends with 'n'.
SELECT * FROM employee WHERE first_name LIKE '%n';
SELECT * FROM employee WHERE SUBSTR(first_name,LENGTH(first_name),1)='n';

--21. Get employee details from employee table whose first name ends with 'n' and name contains 4 letters.
SELECT * FROM employee WHERE first_name LIKE '___n';
SELECT * FROM employee WHERE SUBSTR(first_name,LENGTH(first_name),1)='n' AND LENGTH(first_name)=4;

--22. Get employee details from employee table whose first name starts with 'J' and name contains 4 letters.
SELECT * FROM employee WHERE first_name LIKE 'J___';
SELECT * FROM employee WHERE SUBSTR(first_name,1,1)='J' AND LENGTH(first_name)=4;

--23. Get employee details from employee table who s Salary greater than 600000.
SELECT * FROM employee WHERE salary > 600000;

--24. Get employee details from employee table whose joining year is  2013 .
SELECT * FROM employee WHERE EXTRACT(YEAR FROM joining_date)=2013;
SELECT * FROM employee WHERE TO_CHAR(joining_date,'YYYY')=2013;

--25. Get employee details from employee table whose joining month is  January .
SELECT * FROM employee WHERE EXTRACT(MONTH FROM joining_date)='1';
SELECT * FROM employee WHERE TO_CHAR(joining_date,'MM')=1;

--**26. Get employee details from employee table who joined before January 1st 2013.
SELECT * FROM employee WHERE joining_date < TO_DATE('01-Jan-13', 'DD-Mon-YY');

--27. Get employee details from employee table who joined after January 31st
SELECT * FROM employee WHERE joining_date > TO_DATE('01-Jan-13', 'DD-Mon-YY');

--**28. Get Joining Date and Time from employee table
SELECT TRUNC(joining_date) AS joining_date FROM employee;
--time is not stored in the column

--**29. Get Joining Date, Time including milliseconds from employee table
SELECT TO_CHAR(joining_date, 'DD-MON-YY') AS joining_date FROM employee;
--Milliseconds is not stored in the column

--30. Get difference between JOINING_DATE and INCENTIVE_DATE(bonus) from employee and incentives table.
SELECT 
    e.emp_id,
    (i.incentive_date - e.joining_date) AS days_difference
FROM employee e INNER JOIN incentives i
ON e.emp_id = i.emp_ref_id;

--31. Get department, total salary with respect to a department from employee table.(use GORUP BY clause)
SELECT department,SUM(salary) AS ttl_sal FROM employee 
GROUP BY department;

--32. Get department, total salary with respect to a department from employee table order by total salary descending.
SELECT department,SUM(salary) AS ttl_sal FROM employee 
GROUP BY department ORDER BY ttl_sal DESC;

--33. Get department, no of employees in a department, total salary with respect to a department from employee table order by total salary descending.
SELECT department,COUNT(*) AS no_of_emp,SUM(salary) AS ttl_sal FROM employee 
GROUP BY department ORDER BY ttl_sal DESC;

--34. Get department wise average salary from employee table order by salary ascending?
SELECT department,ROUND(AVG(salary),2) AS avg_sal FROM employee 
GROUP BY department ORDER BY avg_sal ASC;

--35. Get department wise maximum salary from employee table order by salary ascending?
SELECT department,MAX(salary) AS max_sal FROM employee 
GROUP BY department ORDER BY max_sal ASC;

--36. Get department wise minimum salary from employee table order by salary ascending?
SELECT department,MIN(salary) AS min_sal FROM employee 
GROUP BY department ORDER BY min_sal ASC;

--***37. Select no of employees joined with respect to year and month from employee table.
SELECT EXTRACT(YEAR FROM joining_date) AS year,
       EXTRACT(MONTH FROM joining_date) AS month,
       COUNT(*) OVER(partition BY EXTRACT(YEAR FROM joining_date),EXTRACT(MONTH FROM joining_date)) AS no_of_emp 
FROM employee; --not reduce rows
---
SELECT EXTRACT(YEAR FROM joining_date) AS year,EXTRACT(MONTH FROM joining_date) AS month, COUNT(*) AS no_of_emp FROM employee
GROUP BY
    EXTRACT(YEAR FROM joining_date), 
    EXTRACT(MONTH FROM joining_date)  
ORDER BY
    EXTRACT(YEAR FROM joining_date),
    EXTRACT(MONTH FROM joining_date); --reduce rows

--38. Select department,total salary with respect to a department from employee table where total salary greater than 800000 order by Total_Salary descending
SELECT department,SUM(salary) AS ttl_sal FROM employee 
GROUP BY department 
HAVING SUM(salary)>800000
ORDER BY ttl_sal DESC;

--***39. Select employee details from employee table if data in incentive table?
SELECT DISTINCT e.*
FROM employee e INNER JOIN incentives i
ON e.emp_id = i.emp_ref_id;
---
SELECT e.* FROM employee e WHERE EXISTS (
    SELECT 1 FROM incentives i WHERE i.emp_ref_id = e.emp_id
);

--40. Select 20 % of salary from John, 10% of Salary for Roy and for other 15 % of salary from employee table
SELECT first_name,salary,
CASE 
  WHEN first_name='John' THEN salary*0.20
  WHEN first_name='Roy' THEN salary*0.10
  else salary*0.15
END AS emp_sal  
FROM employee;

--41. Select Banking as 'Bank Dept', Insurance as 'Insurance Dept' and Services as 'Services Dept' from employee table.
SELECT first_name,department,
CASE 
  WHEN department='Banking' THEN 'Bank Dept'
  WHEN department='Insurance' THEN 'Insurance Dept'
  else 'Services Dept' 
END AS emp_dept  
FROM employee;

--42. ***Delete employee data from employee table who got incentives in incentive table
SELECT DISTINCT e.*
FROM employee e INNER JOIN incentives i
ON e.emp_id = i.emp_ref_id;
---
SELECT e.* FROM employee e WHERE EXISTS (
    SELECT 1 FROM incentives i WHERE i.emp_ref_id = e.emp_id
);

--43. Select first_name, incentive amount from employee and incentives table for those employees who have incentives.
SELECT e.first_name,i.incentive_amount 
FROM employee e INNER JOIN incentives i 
ON e.emp_id = i.emp_ref_id;

--44. Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000
SELECT e.first_name,i.incentive_amount 
FROM employee e INNER JOIN incentives i 
ON e.emp_id = i.emp_ref_id
WHERE i.incentive_amount>3000;

--45. Select first_name, incentive amount from employee and incentives table for all employees even if they didn't get incentives
SELECT e.first_name,i.incentive_amount 
FROM employee e LEFT JOIN incentives i 
ON e.emp_id = i.emp_ref_id;

--46. Select first_name, incentive amount from employee and incentives table for all employees even if they didn't get incentives and 
--set incentive amount as 0 for those employees who didn't get incentives.
SELECT e.first_name,NVL(i.incentive_amount,0) 
FROM employee e LEFT JOIN incentives i 
ON e.emp_id = i.emp_ref_id;

--47. Select first_name, incentive amount from employee and incentives table for all employees who got incentives using left join
SELECT e.first_name,i.incentive_amount 
FROM employee e LEFT JOIN incentives i 
ON e.emp_id = i.emp_ref_id
WHERE i.incentive_amount IS NOT NULL;

--48. Select max incentive with respect to employee from employee and incentives table using sub query.
SELECT first_name,
       (SELECT MAX(incentive_amount) FROM incentives WHERE emp_ref_id = employee.emp_id) AS max_incentive
FROM employee;
---
SELECT e.first_name,MAX(incentive_amount) AS max_incentives 
FROM employee e LEFT JOIN incentives i ON e.emp_id = i.emp_ref_id
GROUP BY e.first_name;

------------------------------------------------------------------------------------------------------------------------------------------









