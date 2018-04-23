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

# 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT film.title, 
       Count(film_actor.actor_id) AS number_of_actors 
FROM   film 
       INNER JOIN film_actor 
               ON film.film_id = film_actor.film_id 
GROUP  BY film_actor.film_id; 

# 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(inventory_id) 
FROM   inventory 
WHERE  film_id IN (SELECT film_id 
                   FROM   film 
                   WHERE  title = 'Hunchback Impossible'); 
    
# 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT customer.first_name, 
       customer.last_name, 
       Sum(payment.amount) AS total_paid 
FROM   payment 
       JOIN customer 
         ON customer.customer_id = payment.customer_id 
GROUP  BY payment.customer_id 
ORDER  BY customer.last_name; 

# 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence,
# films starting with the letters K and Q have also soared in popularity.
# Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. 
SELECT title 
FROM   film 
WHERE  language_id IN (SELECT language_id 
                       FROM   language 
                       WHERE  NAME = 'English') 
       AND title LIKE 'K%' 
        OR title LIKE 'Q%'; 

# 7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, 
       last_name 
FROM   actor 
WHERE  actor_id IN (SELECT actor_id 
                    FROM   film_actor 
                    WHERE  film_id IN (SELECT film_id 
                                       FROM   film 
                                       WHERE  title = 'Alone Trip'));  

# 7c. You want to run an email marketing campaign in Canada, 
# for which you will need the names and email addresses of all Canadian customers. 
# Use joins to retrieve this information.
SELECT customer.first_name AS 'first_name', 
       customer.last_name  AS 'last_name', 
       customer.email      AS 'email', 
       country.country     AS 'country' 
FROM   customer 
       JOIN address 
         ON address.address_id = customer.address_id 
       JOIN city 
         ON address.city_id = city.city_id 
       JOIN country 
         ON city.country_id = country.country_id 
WHERE  country.country = 'Canada'; 

# 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
SELECT title 
FROM   film 
WHERE  film_id IN (SELECT film_id 
                   FROM   film_category 
                   WHERE  category_id IN (SELECT category_id 
                                          FROM   category 
                                          WHERE  NAME = 'family')); 

# 7e. Display the most frequently rented movies in descending order.
SELECT film.title, 
       Count(film.title) AS number_rentals 
FROM   film 
       JOIN inventory 
         ON film.film_id = inventory.film_id 
       JOIN rental 
         ON inventory.inventory_id = rental.inventory_id 
GROUP  BY film.title 
ORDER  BY number_rentals DESC; 

# 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT inventory.store_id, 
       Sum(payment.amount) AS revenue 
FROM   inventory 
       JOIN rental 
         ON inventory.inventory_id = rental.inventory_id 
       JOIN payment 
         ON rental.customer_id = payment.customer_id 
GROUP  BY inventory.store_id; 

# 7g. Write a query to display for each store its store ID, city, and country.
SELECT store.store_id, 
       city.city, 
       country.country 
FROM   store 
       JOIN address 
         ON store.address_id = address.address_id 
       JOIN city 
         ON city.city_id = address.city_id 
       JOIN country 
         ON country.country_id = city.country_id; 

# 7h. List the top five genres in gross revenue in descending order.
# (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT category.name, 
       SUM(payment.amount) AS total 
FROM   payment 
       JOIN rental 
         ON payment.customer_id = rental.customer_id 
       JOIN inventory 
         ON rental.inventory_id = inventory.inventory_id 
       JOIN film_category 
         ON inventory.film_id = film_category.film_id 
       JOIN category 
         ON film_category.category_id = category.category_id 
GROUP  BY category.category_id 
ORDER  BY total DESC 
LIMIT  5; 

# 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue.
# Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE view top_five_genres 
AS 
  SELECT category.name, 
         Sum(payment.amount) AS total 
  FROM   payment 
         JOIN rental 
           ON payment.customer_id = rental.customer_id 
         JOIN inventory 
           ON rental.inventory_id = inventory.inventory_id 
         JOIN film_category 
           ON inventory.film_id = film_category.film_id 
         JOIN category 
           ON film_category.category_id = category.category_id 
  GROUP  BY category.category_id 
  ORDER  BY total DESC 
  LIMIT  5; 

# 8b. How would you display the view you created in 8a?
SELECT * FROM top_five_genres;

# 8c. You find that you no longer need the view top_five_genres.  Write a query to delete it.
DROP VIEW top_five_genres;
