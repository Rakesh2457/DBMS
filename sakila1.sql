use sakila;
select * from actor;
show tables;
show databases;


-- Find out the PG-13 rated comedy movies. DO NOT use the film_list table.
select film_id,title from film where rating='PG-13' and film_id in (select film_id from film_category where category_id in(select category_id from category where
category.name='Comedy'));

-- Find out the top 3 rented horror movies.

SELECT fl.title, COUNT(ALL fl.title) FROM
    film_list fl,
    inventory i,
    rental r
WHERE
    fl.category = 'Horror'
        AND fl.FID = i.film_id
        AND i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY COUNT(ALL fl.title) DESC
LIMIT 3;

-- Find out the list of customers from India who have rented sports movies.
SELECT * FROM customer_list
WHERE
    country = 'India'
        AND ID IN (SELECT 
            r.customer_id
        FROM
            film_list fl,
            inventory i,
            rental r
        WHERE
            fl.category = 'Sports'
                AND fl.FID = i.film_id
                AND r.inventory_id = i.inventory_id
        GROUP BY r.customer_id);
        
-- Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies.
SELECT * FROM customer_list cl
WHERE
    cl.country = 'Canada'
        AND ID IN (SELECT 
            r.customer_id
        FROM
            actor a,
            film_actor fa,
            inventory i,
            rental r
        WHERE
            a.first_name = 'NICK'
                AND a.last_name = 'WAHLBERG'
                AND a.actor_id = fa.actor_id
                AND fa.film_id = i.film_id
                AND i.inventory_id = r.inventory_id);
                

-- Find out the number of movies in which “SEAN WILLIAMS” acted.
SELECT COUNT(DISTINCT fa.film_id) FROM
    actor a,
    film_actor fa
WHERE
    a.first_name = 'SEAN'
        AND a.last_name = 'WILLIAMS'
        AND fa.actor_id = a.actor_id;






-- 
