/* 1.Customer 'Angel' has rented 'SBA1111A' from today for 10 days. (Hint: You need to insert a rental record. 
Use a SELECT subquery to get the customer_id to do this you will need to use parenthesis for your subquery as one of your values. 
Use CURDATE() (or NOW()) for today, and DATE_ADD(CURDATE(), INTERVAL x unit) to compute a future date.) */
INSERT INTO rental_records VALUES
(NULL, 'SBA1111A', 
(SELECT customer_id FROM customers WHERE name='Angel'),
CURDATE(),
DATE_ADD(CURDATE(), INTERVAL 10 DAY),
NULL);

-- 2.Customer 'Kumar' has rented 'GA5555E' from tomorrow for 3 months.
INSERT INTO rental_records VALUES
(NULL, 'GA5555E', 
(SELECT customer_id FROM customers WHERE name='Kumar'),
CURDATE(),
DATE_ADD(CURDATE(), INTERVAL 91 DAY),
NULL);

/* 3.List all rental records (start date, end date) with vehicle's registration number, 
brand, and customer name, sorted by vehicle's categories followed by start date. */
SELECT
rental_records.start_date AS `Start Date`,
rental_records.end_date AS `End Date`,
rental_records.veh_reg_no AS `Vehicle No`,
vehicles.brand AS `Vehicle Brand`,
customers.name AS `Customer Name`
FROM rental_records 
INNER JOIN vehicles
ON rental_records.veh_reg_no = vehicles.veh_reg_no
INNER JOIN customers 
ON rental_records.customer_id = customers.customer_id
ORDER BY vehicles.category, start_date;

-- 4.List all the expired rental records (end_date before CURDATE()).
SELECT * 
FROM rental_records
WHERE end_date < CURDATE();

/* 5.List the vehicles rented out on '2012-01-10' (not available for rental), in columns of vehicle registration no, 
customer name, start date and end date. (Hint: the given date is in between the start_date and end_date.) */
SELECT
rental_records.start_date AS `Start Date`,
rental_records.end_date AS `End Date`,
rental_records.veh_reg_no AS `Vehicle Reg No`,
customers.name AS `Customer Name`
FROM rental_records
INNER JOIN customers 
ON rental_records.customer_id = customers.customer_id
WHERE start_date < '2012-01-10' AND end_date > '2012-01-10';

-- 6.List all vehicles rented out today, in columns registration number, customer name, start date, end date.
SELECT
rental_records.start_date AS `Start Date`,
rental_records.end_date AS `End Date`,
rental_records.veh_reg_no AS `Registration No`,
customers.name AS `Customer Name`
FROM rental_records
INNER JOIN customers 
ON rental_records.customer_id = customers.customer_id
WHERE start_date = CURDATE();

/* 7.Similarly, list the vehicles rented out (not available for rental) for the period from 
'2012-01-03' to '2012-01-18'. (Hint: start_date is inside the range; or end_date is inside the range; 
or start_date is before the range and end_date is beyond the range.) */
SELECT
rental_records.start_date AS `Start Date`,
rental_records.end_date AS `End Date`,
rental_records.veh_reg_no AS `Registration No`,
customers.name AS `Customer Name`
FROM rental_records
INNER JOIN customers 
ON rental_records.customer_id = customers.customer_id
WHERE start_date BETWEEN '2012-01-03' AND '2012-01-18' 
OR end_date BETWEEN '2012-01-03' AND '2012-01-18'
OR start_date < '2012-01-03';

/* 8.List the vehicles (registration number, brand and description) available for rental (not rented out) 
on '2012-01-10' (Hint: You could use a subquery based on a earlier query). */
SELECT
vehicles.veh_reg_no AS `Reg No`,
vehicles.brand AS `Vehicle Brand`,
vehicles.desc AS `Description`
FROM vehicles
LEFT JOIN rental_records
ON vehicles.veh_reg_no = rental_records.veh_reg_no
WHERE vehicles.veh_reg_no NOT IN(
SELECT veh_reg_no 
FROM rental_records 
WHERE rental_records.start_date < '2012-01-10' AND rental_records.end_date > '2012-01-10');

-- 9.Similarly, list the vehicles available for rental for the period from '2012-01-03' to '2012-01-18'.
SELECT
vehicles.veh_reg_no AS `Reg No`,
vehicles.brand AS `Vehicle Brand`,
vehicles.desc AS `Description`
FROM vehicles
LEFT JOIN rental_records
ON vehicles.veh_reg_no = rental_records.veh_reg_no
WHERE vehicles.veh_reg_no NOT IN (
SELECT veh_reg_no 
FROM rental_records 
WHERE rental_records.start_date <'2012-01-03' OR rental_records.end_date > '2012-01-03'
AND rental_records.start_date < '2012-01-18' AND rental_records.end_date > '2012-01-18');

-- 10.Similarly, list the vehicles available for rental from today for 10 days.
SELECT 
vehicles.veh_reg_no AS `Reg no`,
vehicles.brand AS `Vehicle Brand`,
vehicles.desc AS `Description`
FROM vehicles
LEFT JOIN rental_records
ON vehicles.veh_reg_no = rental_records.veh_reg_no
WHERE vehicles.veh_reg_no NOT IN  (
SELECT veh_reg_no 
FROM rental_records 
WHERE rental_records.start_date BETWEEN curdate() AND date_add(CURDATE(), INTERVAL 10 DAY));

