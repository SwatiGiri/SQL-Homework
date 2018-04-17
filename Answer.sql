Create Database Homework;
Use Sakila;
Show tables;
Select * from actor;
Select * from actor_info;
Select * from country;
#first and last name from table actor
Select first_name , last_name from actor;
SELECT CONCAT(first_name , " " , last_name) as Actor_Name FROM actor ;
#first, last name and ID number of "Joe"
Select first_name , last_name , actor_id from actor_info where first_name LIKE "JOE";
# all actors whose last name contain the letters `GEN`
Select first_name , last_name , actor_id from actor_info 
where last_name like "%GEN" or "GEN%" or "%GEN%" or "GEN";
# actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order
Select last_name, first_name, actor_id from actor_info 
where last_name like "%LI%" 
order by last_name, first_name;
# Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China
Select country_id, country from country 
where country in ("Afghanistan", "Bangladesh", "China");
# Add a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`. Hint: you will need to specify the data type.
ALTER TABLE actor
ADD Middle_name Varchar(15) AFTER first_name;
select * from actor ;
# Change the data type of the `middle_name` column to `blobs`
ALTER TABLE actor
MODIFY COLUMN Middle_name blob;
Select * from actor;
# delete the `middle_name` column
Alter Table actor
Drop column Middle_name;
Select * from actor;

#List the last names of actors, as well as how many actors have that last name

SELECT last_name, COUNT(*) c FROM actor GROUP BY last_name HAVING c >= 1;
# List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(*) c FROM actor GROUP BY last_name HAVING c > 1;
# The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
UPDATE actor SET first_name = 'HARPO'
WHERE first_name = "GROUCHO"  AND last_name = "Williams";

select * from actor where first_name = "HARPO";

#4d 
UPDATE actor SET first_name = 'Grucho'
WHERE first_name = "HARPO"  AND last_name = "Williams";

# query which would you use to re-create it
SHOW CREATE TABLE address;
CREATE TABLE address (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `s` char(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
);
 
 #  `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`
select * from address;
select * from staff;

# `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`
select first_name , last_name from staff join address using (address_id);
SELECT * FROM table1 LEFT JOIN table2 USING (id)
