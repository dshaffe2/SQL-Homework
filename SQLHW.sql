use sakila;

-- 1a
SELECT first_name,
		last_name
FROM actor;

-- 1b
SELECT CONCAT(
				UCASE(first_name),
                ' ',
				UCASE(last_name)
			  ) as 'Actor Name'
FROM actor;

-- 2a
SELECT actor_id,
		first_name,
		last_name
FROM actor
WHERE first_name LIKE 'Joe%';

-- 2b
SELECT *
FROM actor
WHERE last_name LIKE '%gen%';

-- 2c
SELECT *
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name,
		  first_name;

-- 2d          
SELECT country_id,
		country
FROM country
WHERE country IN ('afghanistan', 'bangladesh', 'china');

-- 3a
ALTER TABLE actor
ADD COLUMN description BLOB;

-- 3b
ALTER TABLE actor
DROP COLUMN description;

-- 4a
SELECT last_name,
		COUNT(last_name)
FROM actor
GROUP BY last_name;

-- 4b
SELECT last_name,
		COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- 4c
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' and
		last_name = 'WILLIAMS';

-- 4d        
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' and
		last_name = 'WILLIAMS';

-- 5a        
SHOW CREATE TABLE address;        

-- 6a
SELECT s.*,
		a.address
FROM staff as s
LEFT JOIN address as a
ON a.address_id = s.address_id;

-- 6b
SELECT s.staff_id,
		SUM(p.amount)
FROM staff as s
JOIN payment as p
ON s.staff_id = p.staff_id
GROUP BY s.staff_id;

-- 6c
SELECT f.title,
		COUNT(fa.actor_id)
FROM film as f
INNER JOIN film_actor as fa
ON f.film_id = fa.film_id
GROUP BY f.title;

-- 6d
SELECT COUNT(title)
FROM film
WHERE title = 'Hunchback Impossible';

-- 6e
SELECT c.customer_id,
		c.first_name,
        c.last_name,
		SUM(p.amount)
FROM customer as c
JOIN payment as p
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name;

-- 7a
SELECT title
FROM film as f
JOIN language as l
ON l.language_id = f.language_id
WHERE (f.title LIKE 'K%' OR 
		f.title LIKE 'Q%') AND
        l.name = 'english';

-- 7b
SELECT a.first_name,
		a.last_name
FROM actor as a
JOIN film_actor as fa ON fa.actor_id = a.actor_id
WHERE fa.film_id = (SELECT film_id
					FROM film
					WHERE title = 'Alone Trip');

-- 7c                    
SELECT c.first_name,
		 c.last_name,
         c.email
FROM customer as c
JOIN address as a ON a.address_id = c.address_id
JOIN city ON city.city_id = a.city_id
JOIN country as cy ON cy.country_id = city.country_id
WHERE cy.country = 'Canada';

-- 7d
SELECT f.title
FROM film as f,
		film_category as fc,
        category as c
WHERE f.film_id = fc.film_id AND
		fc.category_id = c.category_id AND
        c.name = 'family';

-- 7e        
SELECT f.title,
		COUNT(r.rental_id)
FROM film as f,
		inventory as i,
        rental as r
WHERE f.film_id = i.film_id AND
		i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;

-- 7f
SELECT *
FROM sakila.sales_by_store;

-- 7g
SELECT s.store_id,
		c.city,
        cy.country
FROM store as s,
		address as a,
        city as c,
        country as cy
WHERE s.address_id = a.address_id AND
		a.city_id = c.city_id AND
        c.country_id = cy.country_id;
        
-- 7h
SELECT c.name,
		SUM(p.amount)
FROM category as c,
		payment as p,
        film_category as fc,
        inventory as i,
        rental as r
WHERE p.rental_id = r.rental_id and
		r.inventory_id = i.inventory_id and
        i.film_id = fc.film_id and
        fc.category_id = c.category_id
GROUP BY c.name
ORDER BY p.amount DESC
LIMIT 5;

-- 8a
CREATE VIEW TheView as
SELECT c.name,
		SUM(p.amount)
FROM category as c,
		payment as p,
        film_category as fc,
        inventory as i,
        rental as r
WHERE p.rental_id = r.rental_id and
		r.inventory_id = i.inventory_id and
        i.film_id = fc.film_id and
        fc.category_id = c.category_id
GROUP BY c.name
ORDER BY p.amount DESC
LIMIT 5;

-- 8b
SELECT *
FROM TheView;

-- 8c
DROP VIEW TheView;