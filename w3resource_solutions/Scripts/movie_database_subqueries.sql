/*
w3resource SQL exercises

Movie database subqueries (16 exercises)
https://www.w3resource.com/sql-exercises/movie-database-exercise/subqueries-exercises-on-movie-database.php
*/

-- 1. From the following table, write a SQL query to find the actors who played a role in the movie 'Annie Hall'. Return all the fields of actor table
SELECT *
FROM actor
WHERE act_id = (SELECT DISTINCT act_id
                FROM movie_cast
                INNER JOIN movie USING(mov_id)
                WHERE mov_title = 'Annie Hall');


-- 2. From the following tables, write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name.
SELECT DISTINCT dir.dir_fname,
       dir.dir_lname
FROM director dir
INNER JOIN movie_direction movdir USING(dir_id)
INNER JOIN movie_cast cas ON movdir.mov_id = cas.mov_id
INNER JOIN movie mov ON cas.mov_id = mov.mov_id
WHERE mov.mov_title = 'Eyes Wide Shut';

-- 3. From the following table, write a SQL query to find those movies, which released in the country besides UK. Return movie title, movie year, movie time, date of release, releasing country. 
SELECT mov_title,
       mov_year,
       mov_time,
       mov_dt_rel,
       mov_rel_country 
FROM movie
WHERE mov_rel_country <> 'UK';

-- 4. From the following tables, write a SQL query to find those movies where reviewer is unknown. Return movie title, year, release date, director first name, last name, actor first name, last name. 
SELECT DISTINCT mov.mov_title AS "Movie title",
       mov_year, 
       mov_dt_rel AS "Date of release",
       dir.dir_fname AS "Director first name",
       dir.dir_lname AS "Director last name",
       act.act_fname AS "Actor first name",
       act.act_lname AS "Actor last name"
FROM movie mov
INNER JOIN movie_direction movdir ON mov.mov_id = movdir.mov_id
INNER JOIN director dir ON movdir.dir_id = dir.dir_id
INNER JOIN movie_cast movcast ON mov.mov_id = movcast.mov_id
INNER JOIN actor act ON movcast.act_id = act.act_id
INNER JOIN rating rat ON mov.mov_id = rat.mov_id
INNER JOIN reviewer rev ON rat.rev_id = rev.rev_id
WHERE rev.rev_name IS NULL;

-- 5. From the following tables, write a SQL query to find those movies directed by the director whose first name is ‘Woddy’ and last name is ‘Allen’. Return movie title
SELECT DISTINCT mov.mov_title
FROM movie mov
INNER JOIN movie_direction USING(mov_id)
INNER JOIN director dir USING(dir_id)
WHERE dir.dir_fname = 'Woody' 
      AND dir.dir_lname = 'Allen';

-- 6. From the following tables, write a SQL query to find those years, which produced at least one movie and that, received a rating of more than three stars. Sort the result-set in ascending order by movie year. Return movie year. 
SELECT mov_year
FROM movie
WHERE mov_id IN (SELECT mov_id
		 FROM rating
		 WHERE rev_stars > 3)
GROUP BY mov_year
HAVING COUNT(*) >= 1
ORDER BY mov_year;

-- 7. From the following table, write a SQL query to find those movies, which have no ratings. Return movie title
SELECT mov_title
FROM movie
WHERE mov_id NOT IN (SELECT mov_id
		     FROM rating);

-- 8. From the following tables, write a SQL query to find those reviewers who have rated nothing for some movies. Return reviewer name. 
SELECT rev_name
FROM reviewer
WHERE rev_id IN (SELECT rev_id 
		 FROM rating
		 WHERE rev_stars IS NULL);

-- 9. From the following tables, write a SQL query to find those movies, which reviewed by a reviewer and got a rating. Sort the result-set in ascending order by reviewer name, movie title, review Stars. Return reviewer name, movie title, review Stars.		 
SELECT DISTINCT rev.rev_name AS "Reviewer",
       mov.mov_title,
       rating.rev_stars
FROM reviewer rev
INNER JOIN rating USING(rev_id)
INNER JOIN movie mov USING(mov_id)
WHERE rating.mov_id IN (SELECT mov_id
                        FROM rating)
      AND rating.rev_stars IS NOT NULL
      AND rev.rev_name IS NOT NULL
ORDER BY rev.rev_name, mov.mov_title, rating.rev_stars;


-- 10. From the following tables, write a SQL query to find those reviewers who rated more than one movie. Group the result set on reviewer’s name, movie title. Return reviewer’s name, movie title.
SELECT DISTINCT rev.rev_name,
       mov.mov_title
FROM reviewer rev
INNER JOIN rating USING(rev_id)
INNER JOIN movie mov USING(mov_id)
WHERE rev.rev_id IN (SELECT DISTINCT rev_id
                     FROM rating
                     GROUP BY rev_id
                     HAVING COUNT(DISTINCT mov_id) > 1)
GROUP BY rev.rev_name, mov.mov_title	     

-- 11. From the following tables, write a SQL query to find those movies, which have received highest number of stars. Group the result set on movie title and sorts the result-set in ascending order by movie title. 
--     Return movie title and maximum number of review stars.
SELECT DISTINCT mov.mov_title,
       MAX(rating.rev_stars)
FROM movie mov
INNER JOIN rating USING(mov_id)
GROUP BY mov.mov_title
ORDER BY mov.mov_title;

-- 12. From the following tables, write a SQL query to find all reviewers who rated the movie 'American Beauty'. Return reviewer name
SELECT DISTINCT rev.rev_name
FROM reviewer rev
INNER JOIN rating USING(rev_id)
INNER JOIN movie mov USING(mov_id)
WHERE mov.mov_title = 'American Beauty';


-- 13. From the following tables, write a SQL query to find the movies, which have reviewed by any reviewer body except by 'Paul Monks'. Return movie title.
SELECT DISTINCT mov.mov_title
FROM movie mov
INNER JOIN rating USING(mov_id)
INNER JOIN reviewer rev USING(rev_id)
WHERE rev.rev_name <> 'Paul Monks';

-- 14. From the following tables, write a SQL query to find the lowest rated movies. Return reviewer name, movie title, and number of stars for those movies. 
SELECT DISTINCT rev.rev_name,
       mov.mov_title,
       rating.rev_stars
FROM reviewer rev
INNER JOIN rating USING(rev_id)
INNER JOIN movie mov USING(mov_id)
WHERE rating.rev_stars IN (SELECT MIN(rev_stars)
			   FROM rating);

-- 15. From the following tables, write a SQL query to find the movies directed by 'James Cameron'. Return movie title.	   
SELECT DISTINCT mov.mov_title
FROM movie mov
INNER JOIN movie_direction USING(mov_id)
INNER JOIN director dir USING(dir_id)
WHERE dir.dir_fname = 'James' 
      AND dir.dir_lname = 'Cameron';

-- 16. Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies
SELECT DISTINCT mov.mov_title
FROM movie mov
INNER JOIN movie_cast USING(mov_id)
INNER JOIN actor USING(act_id)
WHERE actor.act_id IN (SELECT DISTINCT act_id
                       FROM movie_cast
                       GROUP BY act_id
                       HAVING COUNT(act_id) > 1); 






		     