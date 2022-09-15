-- 1. Write a query to display for each store its store ID, city, and country.
SELECT * FROM sakila.store; -- store_id, address_id
SELECT * FROM sakila.address; -- address_id,  city_id
SELECT * FROM sakila.city; -- city_id, city, country_id
SELECT * FROM sakila.country; -- country_id, country

SELECT s.store_id, c.city, co.country
FROM sakila.store s
JOIN sakila.address a USING (address_id)
JOIN sakila.city c USING (city_id)
JOIN sakila.country co USING (country_id)
order by s.store_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT * FROM sakila.payment; -- payment_id, amount, staff_id
SELECT * FROM sakila.staff; -- staff_id,  store_id

SELECT s.staff_id, s.store_id, sum(p.amount) AS 'Income'
FROM sakila.payment p
join sakila.staff s using (staff_id)
group by s.staff_id;

-- 3. Which film categories are longest?
SELECT * FROM sakila.category; -- category_id, name
SELECT * FROM sakila.film_category; -- film_id,  category_id
SELECT * FROM sakila.film; -- lenght, title, film_id

SELECT c.category_id, c.name, AVG(length)
FROM sakila.category c
JOIN sakila.film_category fc using (category_id)
JOIN sakila.film f using (film_id)
GROUP BY (c.name)
ORDER BY AVG(length) DESC;

-- 4. Display the most frequently rented movies in descending order.
SELECT * FROM sakila.inventory; -- inventory_id, film_id
SELECT * FROM sakila.film; -- film_id, title, 
SELECT * FROM sakila.rental; -- rental_id, inventory_id

SELECT f.film_id, f.title, COUNT(distinct r.rental_id) AS 'rented_times'
FROM sakila.film f
JOIN sakila.inventory i using (film_id)
JOIN sakila.rental r using (inventory_id)
GROUP BY f.film_id
ORDER BY COUNT(distinct r.rental_id) DESC;

-- 5. List the top five genres in gross revenue in descending order.
SELECT * FROM sakila.rental; -- inventory_id, staff_id
SELECT * FROM sakila.inventory; -- film_id, inventory_id
SELECT * FROM sakila.film_category; -- category_id,  film_id
SELECT * FROM sakila.category; -- name(genre), category_id
SELECT * FROM sakila.payment; -- payment_id, amount, staff_id

SELECT sum(p.amount) AS 'Income'
FROM sakila.payment p
join sakila.rental r using (staff_id)
join sakila.inventory i using (inventory_id)
join sakila.film_category fc using (film_id)
join sakila.category c using (category_id)
group by c.category_id
order by sum(p.amount) desc
Limit 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?
SELECT * FROM sakila.film; -- film_id, title
SELECT * FROM sakila.inventory; -- film_id, inventory_id, store_id

SELECT i.store_id, i.inventory_id, film_id, f.title
FROM sakila.film f
join sakila.inventory i using (film_id)
where f.title = "Academy Dinosaur" AND i.store_id = 1;

-- 7. Get all pairs of actors that worked together.
SELECT * FROM sakila.film; -- film_id, title
SELECT * FROM sakila.film_actor; -- actor_id, film_id
SELECT * FROM sakila.actor; -- actor_id, f&L_name

SELECT fa1.film_id, a.actor_id, a.first_name, a.last_name
FROM sakila.film_actor fa1
JOIN sakila.actor a USING (actor_id)
JOIN sakila.film_actor fa2
ON (fa1.actor_id <> fa2.actor_id) AND (fa1.film_id = fa2.film_id)
group by fa1.actor_id
ORDER BY fa1.film_id;

-- 8. Get all pairs of customers that have rented the same film more than 3 times.
SELECT * FROM sakila.customer; -- customer_id, f&L_name
SELECT * FROM sakila.rental; -- rental_id, customer_id, inventory_id
SELECT * FROM sakila.inventory; -- inventory_id, film_id

-- 9. For each film, list actor that has acted in more films.
SELECT * FROM sakila.film_actor; -- actor_id, film_id
SELECT * FROM sakila.actor; -- actor_id, f&L_name