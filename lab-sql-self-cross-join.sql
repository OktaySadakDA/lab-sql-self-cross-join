use sakila;

# 1. Get all pairs of actors that worked together.
select* from film_actor;

select a.actor_id,b.actor_id,c.title
from film_actor a,film_actor b
join film c on b.film_id=c.film_id
where a.actor_id!=b.actor_id and a.film_id=b.film_id
order by a.film_id;

SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

SELECT fa1.actor_id as actor_1,fa2.film_id,fa2.actor_id as actor_2, f.title
FROM film_actor fa1
JOIN film_actor fa2
ON fa1.film_id = fa2.film_id
JOIN film f
ON fa1.film_id = f.film_id
WHERE fa1.actor_id != fa2.actor_id AND fa1.film_id = fa2.film_id
order by fa1.film_id;

# 2.Get all pairs of customers that have rented the same film more than 3 times.

SHOW VARIABLES LIKE "%timeout";
SET GLOBAL connect_timeout = 600; 

select film.film_id,r1.customer_id as c1, r2.customer_id as c2, count(*) as total_counts
from rental r1
join rental r2
on r1.inventory_id=r2.inventory_id and r1.customer_id!=r2.customer_id
join inventory film
on film.inventory_id=r2.inventory_id
group by film.film_id,r1.customer_id,r2.customer_id
having count(*)>1;


# 3.Get all possible pairs of actors and films.
select ac1.actor_id,ac1.first_name,ac1.last_name,ac2.actor_id,ac2.first_name,ac2.last_name,film.title,film.film_id
from actor ac1,actor ac2
cross join film
where ac1.actor_id!=ac2.actor_id;