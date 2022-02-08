/*
w3resource SQL exercises

Movie database basic queries (10 exercises)
https://www.w3resource.com/sql-exercises/movie-database-exercise/basic-exercises-on-movie-database.php
*/

-- 1. From the following table, write a SQL query to find the name and year of the movies. Return movie title, movie release year.
SELECT mov_title,
       mov_year
FROM movie;

-- 2. From the following table, write a SQL query to find when the movie ‘American Beauty’ released. Return movie release year.
SELECT mov_year
FROM movie
WHERE mov_title = 'American Beauty';

-- 3. From the following table, write a SQL query to find when the movie ‘American Beauty’ released. Return movie release year.
SELECT mov_title
FROM movie
WHERE mov_year = 1999;

-- 4. From the following table, write a SQL query to find those movies, which was made before 1998. Return movie title. 
SELECT mov_title
FROM movie
WHERE mov_year < 1998;

-- 5. From the following tables, write a SQL query to find the name of all reviewers and movies together in a single list.
SELECT rev_name
FROM reviewer

UNION

SELECT mov_title
FROM movie;

-- 6. From the following tables, write a SQL query to find all reviewers who have rated 7 or more stars to their rating. Return reviewer name.
SELECT rev.rev_name
FROM reviewer rev
INNER JOIN rating USING(rev_id)
WHERE rating.rev_stars >= 7
      AND rev.rev_name IS NOT NULL; 

-- 7. From the following tables, write a SQL query to find the movies without any rating. Return movie title.
SELECT mov_title
FROM movie       
WHERE mov_id NOT IN (SELECT mov_id
                     FROM rating);

-- 8. From the following table, write a SQL query to find the movies with ID 905 or 907 or 917. Return movie title
SELECT mov_title
FROM movie
WHERE mov_id IN (905, 907, 917);

-- 9. From the following table, write a SQL query to find those movie titles, which include the words 'Boogie Nights'. Sort the result-set in ascending order by movie year. Return movie ID, movie title and movie release year. 
SELECT mov_id,
       mov_title,
       mov_year
FROM movie
WHERE mov_title LIKE '%Boogie Nights%';


-- 10. From the following table, write a SQL query to find those actors whose first name is 'Woody' and the last name is 'Allen'. Return actor ID 
SELECT act_id
FROM actor 
WHERE act_fname = 'Woody' 
      AND act_lname = 'Allen';