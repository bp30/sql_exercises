/*
w3resource SQL exercises

Movie database joins (24 exercises)
https://www.w3resource.com/sql-exercises/movie-database-exercise/joins-exercises-on-movie-database.php
*/

-- 1. From the following tables, write a SQL query to find the name of all reviewers who have rated their ratings with a NULL value. Return reviewer name.
SELECT rev.rev_name
FROM reviewer rev
INNER JOIN rating USING (rev_id)
WHERE rating.rev_stars IS NULL;

-- 2. From the following tables, write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role. 
SELECT act.act_fname,
       act.act_lname,
       movcast.role
FROM actor act
INNER JOIN movie_cast movcast USING(act_id)
INNER JOIN movie mov USING(mov_id)
WHERE mov.mov_title = 'Annie Hall';

-- 3. From the following tables, write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name and movie title.
SELECT dir.dir_fname,
       dir.dir_lname,
       mov.mov_title
FROM director dir
INNER JOIN movie_direction movdir USING(dir_id)
INNER JOIN movie_cast movcast ON movdir.mov_id = movcast.mov_id
INNER JOIN movie mov ON movdir.mov_id = mov.mov_id
WHERE mov.mov_title = 'Eyes Wide Shut';

-- 4. From the following tables, write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. Return director first name, last name and movie title. 
SELECT dir.dir_fname,
       dir.dir_lname,
       mov.mov_title
FROM director dir
INNER JOIN movie_direction movdir USING(dir_id)
INNER JOIN movie_cast movcast ON movdir.mov_id = movcast.mov_id
INNER JOIN movie mov ON movdir.mov_id = mov.mov_id
WHERE movcast.role = 'Sean Maguire';

-- 5. From the following tables, write a SQL query to find the actors who have not acted in any movie between1990 and 2000 (Begin and end values are included.). Return actor first name, last name, movie title and release year. 
SELECT act.act_fname,
       act.act_lname,
       mov.mov_title,
       mov.mov_year
FROM actor act
INNER JOIN movie_cast movcats USING(act_id)
INNER JOIN movie mov USING(mov_id)
WHERE mov.mov_year NOT BETWEEN 1990 AND 2000;   

-- 6. From the following tables, write a SQL query to find the directors with number of genres movies. Group the result set on director first name, last name and generic title. Sort the result-set in ascending order by director first name and last name. Return director first name, last name and number of genres movies. 
SELECT dir.dir_fname,
       dir.dir_lname,
       COUNT(gen_id) 
FROM director dir
INNER JOIN movie_direction movdir USING(dir_id)
INNER JOIN movie_genres movgen USING(mov_id)
INNER JOIN genres gen USING(gen_id)
GROUP BY dir.dir_fname, 
	 dir.dir_lname, 
	 gen.gen_title
ORDER BY dir.dir_fname, 
	 dir.dir_lname;	 

-- 7. From the following table, write a SQL query to find the movies with year and genres. Return movie title, movie year and generic title.
SELECT mov.mov_title,
       mov.mov_year,
       gen.gen_title
FROM movie mov 
INNER JOIN movie_genres USING(mov_id)
INNER JOIN genres gen USING(gen_id);  	 

-- 8. From the following tables, write a SQL query to find all the movies with year, genres, and name of the director.
SELECT mov.mov_title,
       mov.mov_year,
       gen.gen_title,
       dir.dir_fname,
       dir.dir_lname
FROM movie mov
JOIN movie_genres movgen ON mov.mov_id = movgen.mov_id
JOIN genres gen USING(gen_id)
JOIN movie_direction movdir ON mov.mov_id = movdir.mov_id
JOIN director dir USING(dir_id);

-- 9. From the following tables, write a SQL query to find the movies released before 1st January 1989. Sort the result-set in descending order by date of release. Return movie title, release year, date of release, duration, and first and last name of the director.
SELECT mov.mov_title,
       mov.mov_year,
       mov.mov_dt_rel,
       mov.mov_time,
       dir.dir_fname,
       dir.dir_lname
FROM movie mov
JOIN movie_direction USING(mov_id)
JOIN director dir USING(dir_id)
WHERE mov.mov_dt_rel < '1989-01-01'
ORDER BY mov.mov_dt_rel DESC;

-- 10. From the following tables, write a SQL query to compute the average time and count number of movies for each genre. Return genre title, average time and number of movies for each genre.
SELECT gen.gen_title,
       AVG(mov.mov_time),
       COUNT(gen.gen_id)
FROM movie mov
JOIN movie_genres USING(mov_id)
JOIN genres gen USING(gen_id)
GROUP BY gen.gen_title;

-- 11. From the following tables, write a SQL query to find movies with the lowest duration. Return movie title, movie year, director first name, last name, actor first name, last name and role.
SELECT mov.mov_title,
       mov.mov_year,
       dir.dir_fname,
       dir.dir_lname,
       act.act_fname,
       act.act_lname,
       movcast.role
FROM movie mov
JOIN movie_direction movdir ON mov.mov_id = movdir.mov_id
JOIN director dir USING(dir_id)
JOIN movie_cast movcast ON mov.mov_id = movcast.mov_id
JOIN actor act USING(act_id)
WHERE mov.mov_id = (SELECT mov_id
                    FROM movie
                    WHERE mov_time = (SELECT MIN(mov_time) 
				      FROM movie));

-- 12. From the following tables, write a SQL query to find those years when a movie received a rating of 3 or 4. Sort the result in increasing order on movie year. Return move year. 
SELECT mov.mov_year
FROM movie mov
JOIN rating USING(mov_id)
WHERE rating.rev_stars IN (3, 4);

-- 13. From the following tables, write a SQL query to get the reviewer name, movie title, and stars in an order that reviewer name will come first, then by movie title, and lastly by number of stars.bb				     
SELECT rev.rev_name,
       mov.mov_title,
       rating.rev_stars
FROM movie mov
JOIN rating USING(mov_id)
JOIN reviewer rev USING(rev_id)
ORDER BY rev.rev_name, 
	 mov.mov_title,
	 rating.rev_stars;

-- 14. From the following tables, write a SQL query to find those movies that have at least one rating and received highest number of stars. Sort the result-set on movie title. Return movie title and maximum review stars.
WITH mov_one_rating AS (
SELECT *
FROM rating
WHERE rev_stars >= 1
)

SELECT mov.mov_title,
       MAX(rating.rev_stars)
FROM movie mov
JOIN mov_one_rating rating USING(mov_id)
GROUP BY mov.mov_title
ORDER BY mov.mov_title;

-- 15. From the following tables, write a SQL query to find those movies, which have received ratings. Return movie title, director first name, director last name and review stars.
SELECT mov.mov_title,
       dir.dir_fname,
       dir.dir_lname,
       rating.rev_stars
FROM movie mov
JOIN rating ON mov.mov_id = rating.mov_id
JOIN movie_direction movdir ON mov.mov_id = movdir.mov_id
JOIN director dir USING(dir_id)
WHERE rating.rev_stars IS NOT NULL;

-- 16. Write a query in SQL to find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies.
SELECT mov.mov_title,
       act.act_fname,
       act.act_lname,
       movcast.role
FROM movie mov
JOIN movie_cast movcast USING(mov_id)
JOIN actor act USING(act_id)
WHERE act.act_id IN (SELECT act_id
                     FROM movie_cast 
                     GROUP BY act_id
                     HAVING COUNT(DISTINCT mov_id) >= 2);

-- 17. From the following tables, write a SQL query to find the actor whose first name is 'Claire' and last name is 'Danes'. Return director first name, last name, movie title, actor first name and last name, role.
SELECT dir.dir_fname,
       dir.dir_lname,
       mov.mov_title,
       act.act_fname,
       act.act_lname,
       movcast.role
FROM director dir
JOIN movie_direction movdir USING (dir_id)
JOIN movie_cast movcast ON movdir.mov_id = movcast.mov_id
JOIN movie mov ON movdir.mov_id = mov.mov_id
JOIN actor act USING(act_id)
WHERE act.act_fname = 'Claire'
      AND act.act_lname = 'Danes';

-- 18. From the following tables, write a SQL query to find those actors who have directed their movies. Return actor first name, last name, movie title and role.
SELECT act.act_fname,
       act.act_lname,
       mov.mov_title,
       movcast.role
FROM actor act 
JOIN movie_cast movcast USING(act_id)
JOIN movie mov ON movcast.mov_id = mov.mov_id
JOIN movie_direction movdir ON movcast.mov_id = movdir.mov_id
JOIN director dir USING(dir_id)
WHERE act.act_fname = dir.dir_fname
      AND act.act_lname = dir.dir_lname;

-- 19. From the following tables, write a SQL query to find the cast list of the movie ‘Chinatown’. Return first name, last name. 
SELECT act.act_fname,
       act.act_lname
FROM actor act
JOIN movie_cast USING(act_id)
JOIN movie mov ON movie_cast.mov_id = mov.mov_id
WHERE mov.mov_title = 'Chinatown';

-- 20. From the following tables, write a SQL query to find those movies where actor’s first name is 'Harrison' and last name is 'Ford'. Return movie title.
SELECT mov.mov_title
FROM movie mov
JOIN movie_cast mov_cast ON mov.mov_id = mov_cast.mov_id
JOIN actor act ON mov_cast.act_id = act.act_id
WHERE act.act_fname = 'Harrison'
      AND act.act_lname = 'Ford';

-- 21. From the following tables, write a SQL query to find the highest-rated movies. Return movie title, movie year, review stars and releasing country.
SELECT mov.mov_title,
       mov.mov_year,
       rating.rev_stars,
       mov.mov_rel_country
FROM movie mov
JOIN rating ON mov.mov_id = rating.mov_id
WHERE rating.rev_stars = (SELECT MAX(rev_stars)
			  FROM rating);

-- 22. From the following tables, write a SQL query to find the highest-rated ‘Mystery Movies’. Return the title, year, and rating.'
WITH mystery_rating AS (
SELECT rating.mov_id,
       rev_stars
FROM rating
JOIN movie_genres movgen ON rating.mov_id = movgen.mov_id
JOIN genres gen ON movgen.gen_id = gen.gen_id
WHERE gen.gen_title = 'Mystery'
)

SELECT mov.mov_title,
       mov.mov_year,
       rating.rev_stars
FROM movie mov
JOIN rating ON mov.mov_id = rating.mov_id
WHERE mov.mov_id IN (SELECT mov_id 
		     FROM mystery_rating
		     WHERE rev_stars = (SELECT MAX(rev_stars)
		                        FROM mystery_rating));
		
-- 23. From the following tables, write a SQL query to find the years when most of the ‘Mystery Movies’ produced. Count the number of generic title and compute their average rating. Group the result set on movie release year, generic title. Return movie year, generic title, number of generic title and average rating. 
SELECT mov.mov_year,
       gen.gen_title,
       COUNT(gen.gen_title),
       AVG(rating.rev_stars)
FROM movie mov
JOIN movie_genres movgen ON mov.mov_id = movgen.mov_id
JOIN genres gen ON movgen.gen_id = gen.gen_id
JOIN rating ON mov.mov_id = rating.mov_id
WHERE gen.gen_title = 'Mystery'
GROUP BY mov.mov_year, gen.gen_title;

-- 24.  From the following tables, write a query in SQL to generate a report, which contain the fields movie title, name of the female actor, year of the movie, role, movie genres, the director, date of release, and rating of that movie.
SELECT DISTINCT mov.mov_title,
       act.act_fname,
       act.act_lname,
       mov.mov_year,
       movcast.role,
       mov.mov_dt_rel,
       rating.rev_stars 
FROM movie mov
JOIN rating ON mov.mov_id = rating.mov_id
JOIN movie_direction movdir ON mov.mov_id = movdir.mov_id
JOIN director dir ON movdir.dir_id = dir.dir_id
JOIN movie_genres movgen ON mov.mov_id = movgen.mov_id
JOIN genres gen ON movgen.gen_id = gen.gen_id
JOIN movie_cast movcast ON mov.mov_id = movcast.mov_id
JOIN actor act ON movcast.act_id = act.act_id
WHERE act.act_gender = 'F';






