-- 1. Convert the given query into a simple stored procedure.
  /* 
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  */

Delimiter // 
create procedure action_customers ()
begin
  select first_name, last_name, email as lists
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
end //
delimiter ;

call action_customers();

-- 2. Modify the stored procedure to accept a category name as an argument and return results for customers who rented movies of that category.
Delimiter // 
create procedure customers_by_genre(in genre varchar(20))
begin
  select first_name, last_name, email as lists
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = genre
  group by first_name, last_name, email;
  
end //
delimiter ;

call customers_by_genre("children");

-- 3. Write a query to check the number of movies released in each movie category.
SELECT name as category, count(film_id) as film_count
FROM film_category
JOIN category
USING (category_id)
GROUP BY category_id;

-- 4. Convert the previous query into a stored procedure that filters only those categories 
-- where the number of movies released is greater than a given number. Pass that number as an argument.

delimiter //
create procedure movie_category_count (in number_movies int)
begin
	SELECT name as category, count(film_id) as film_count
	FROM film_category
	JOIN category
	USING (category_id)
	GROUP BY category_id
    HAVING count(film_id) > number_movies;
END //

delimiter ;

call movie_category_count(75);