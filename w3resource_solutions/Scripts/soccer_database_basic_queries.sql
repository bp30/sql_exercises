/*
w3resource SQL exercises

Soccer database basic queries (29 exercises)
https://www.w3resource.com/sql-exercises/soccer-database-exercise/basic-exercises-on-soccer-database.php
*/

-- 1. From the following table, write a SQL query to count the number of venues for EURO cup 2016. Return number of venues. 
SELECT COUNT(*)
FROM soccer_venue;

-- 2. From the following table, write a SQL query to count the number of countries participated in the EURO cup 2016.
SELECT COUNT(DISTINCT team_id)
FROM player_mast;

-- 3. From the following table, write a SQL query to find the number of goals scored in EURO cup 2016 within normal play schedule.
SELECT COUNT(goal_id)
FROM goal_details;

-- 4. From the following table, write a SQL query to find the number of matches ended with a result. 
SELECT COUNT(*)
FROM match_mast
WHERE results <> 'DRAW';

-- 5. From the following table, write a SQL query to find the number of matches ended with draws.
SELECT COUNT(*)
FROM match_mast
WHERE results = 'DRAW';

-- 6. From the following table, write a SQL query to find the date when Football EURO cup 2016 begins.
SELECT MIN(play_date) AS "Beginning Date"
FROM match_mast;

-- 7. From the following table, write a SQL query to find the number of self-goals scored in EURO cup 2016.
SELECT COUNT(*)
FROM goal_details
WHERE goal_type = 'O';

-- 8. From the following table, write a SQL query to count the number of matches ended with a results in-group stage.  
SELECT COUNT(*) 
FROM match_mast
WHERE play_stage = 'G'
      AND results <> 'DRAW';

-- 9. From the following table, write a SQL query to find the number of matches got a result by penalty shootout.
SELECT COUNT(DISTINCT match_no)
FROM penalty_shootout
WHERE score_goal = 'Y';

-- 10. From the following table, write a SQL query to find the number of matches decided by penalties in the Round 16. 
SELECT COUNT(*)
FROM match_mast
WHERE play_stage = 'R'
      AND decided_by = 'P'; 

-- 11. From the following table, write a SQL query to find the number of goal scored in every match within normal play schedule. Sort the result-set on match number. Return match number, number of goal scored. 
SELECT match_no,
       COUNT(*)
FROM goal_details
GROUP BY match_no
ORDER BY match_no; 

-- 12. From the following table, write a SQL query to find those matches where no stoppage time added in the first half of play. Return match no, date of play, and goal scored.
SELECT match_no,
       play_date,
       goal_score
FROM match_mast 
WHERE stop1_sec = 0;          

-- 13. From the following table, write a SQL query to count the number of matches ending with a goalless draw in-group stage of play. Return number of matches.
SELECT COUNT(DISTINCT match_no)
FROM match_details
WHERE play_stage = 'G'
      AND goal_score = 0
      AND win_lose = 'D';

-- 14. From the following table, write a SQL query to count the number of matches ending with only one goal win, except those matches, which was decided by penalty shoot-out. Return number of matches.
SELECT COUNT(DISTINCT match_no)
FROM match_details
WHERE goal_score = 1
      AND win_lose = 'W'
      AND decided_by = 'P';

-- 15. From the following table, write a SQL query to count the number of players replaced in the tournament. Return number of players as "Player Replaced".
SELECT COUNT(*)  AS "Player Replaced"
FROM player_in_out
WHERE in_out = 'I';

-- 16. From the following table, write a SQL query to count the total number of players replaced within normal time of play. Return number of players as "Player Replaced".
SELECT COUNT(*)  AS "Player Replaced"
FROM player_in_out
WHERE in_out = 'I'
      AND play_schedule = 'NT';

-- 17.  From the following table, write a SQL query to count the number of players replaced in the stoppage time. Return number of players as "Player Replaced".     
SELECT COUNT(*) AS "Player Replaced"
FROM player_in_out
WHERE in_out = 'I'
      AND play_schedule = 'ST';

-- 18. From the following table, write a SQL query to count the total number of players replaced in the first half of play. Return number of players as "Player Replaced". 
SELECT COUNT(*) AS "Player Replaced"
FROM player_in_out
WHERE in_out = 'I'
      AND play_schedule = 'NT'
      AND play_half = 1;

-- 19. From the following table, write a SQL query to count the total number of goalless draws have there in the entire tournament. Return number of goalless draws.
SELECT COUNT(DISTINCT match_no)
FROM match_details
WHERE goal_score = 0
      AND win_lose = 'D';

-- 20. From the following table, write a SQL query to count the total number of players replaced in the extra time of play. 
SELECT COUNT(*) / 4 
FROM player_in_out
WHERE in_out = 'I'
      AND play_schedule = 'ET';

-- 21.  From the following table, write a SQL query to count the number of substitute happened in various stage of play for the entire Tournament. 
--      Sort the result-set in ascending order by play-half, play-schedule and number of substitute happened. Return play-half, play-schedule, number of substitute happened.               
SELECT play_half,
       play_schedule,
       COUNT(*)
FROM player_in_out
WHERE in_out = 'I'
GROUP BY play_half,
         play_schedule
ORDER BY play_half,
         play_schedule,
         COUNT(*);         

-- 22.  From the following table, write a SQL query to count the number of shots taken in penalty shootout matches. Number of shots as "Number of Penalty Kicks". 
SELECT COUNT(*) AS "Number of Penalty Kicks"
FROM penalty_shootout;

-- 23. From the following table, write a SQL query to count the number of shots scored goal in penalty shootout matches. Return number of shots scored goal as "Goal Scored by Penalty Kicks".
SELECT COUNT(*) AS "Goal Scored by Penalty Kicks"
FROM penalty_shootout
WHERE score_goal = 'Y';

-- 24. From the following table, write a SQL query to count the number of shots missed or saved in penalty shootout matches. Return number of shots missed as "Goal missed or saved by Penalty Kicks".
SELECT COUNT(*) AS "Goal missed or saved by Penalty Kicks"
FROM penalty_shootout
WHERE score_goal = 'N';

-- 25. From the following tables, write a SQL query to find the players with shot number they taken in penalty shootout matches. Return match_no, Team, player_name, jersey_no, score_goal, kick_no.
SELECT pen.match_no,
       count.country_name AS "Team",
       player.player_name,
       player.jersey_no,
       pen.score_goal,
       pen.kick_no 
FROM penalty_shootout pen
JOIN player_mast player ON pen.player_id = player.player_id
JOIN soccer_country count ON pen.team_id = count.country_id;

-- 26. From the following tables, write a SQL query to count the number of penalty shots taken by the teams. Return country name, number of shots as "Number of Shots". 
SELECT count.country_name,
       COUNT(*) AS "Number of Shots"
FROM soccer_country count
JOIN penalty_shootout pen ON count.country_id = pen.team_id
GROUP BY count.country_name;


-- 27. From the following table, write a SQL query to count the number of booking happened in each half of play within normal play schedule. Return play_half, play_schedule, number of booking happened. 
SELECT play_half,
       play_schedule,
       COUNT(*)
FROM player_booked
WHERE play_schedule = 'NT'
GROUP BY play_half, play_schedule;

-- 28. From the following table, write a SQL query to count the number of booking happened in stoppage time.
SELECT COUNT(*) 
FROM player_booked
WHERE play_schedule = 'ST';      

-- 29. From the following table, write a SQL query to count the number of booking happened in extra time. 
SELECT COUNT(*) 
FROM player_booked
WHERE play_schedule = 'ET';  




      