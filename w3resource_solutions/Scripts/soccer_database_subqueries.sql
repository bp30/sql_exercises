/*
w3resource SQL exercises

Soccer database subqueries (33 exercises)
https://www.w3resource.com/sql-exercises/soccer-database-exercise/subqueries-exercises-on-soccer-database.php
*/

-- 1. From the following tables, write a SQL query to find the teams played the first match of EURO cup 2016. Return match number, country name. 
SELECT matdet.match_no,
       count.country_name
FROM match_details matdet
JOIN soccer_country count ON matdet.team_id = count.country_id
WHERE matdet.match_no = 1;

-- 2. From the following tables, write a SQL query to find the winner of EURO cup 2016. Return country name.
SELECT count.country_name
FROM soccer_country count
JOIN match_details matdet ON count.country_id = matdet.team_id
WHERE matdet.win_lose = 'W' AND
      matdet.match_no = (SELECT MAX(match_no)
			 FROM match_details);

-- 3. From the following table, write a SQL query to find the most watched match in the world. Return match_no, play_stage, goal_score, audience.
SELECT match_no,
       play_stage,
       goal_score, 
       audence
FROM match_mast
WHERE audence = (SELECT MAX(audence)
		 FROM match_mast);

-- 4. From the following tables, write a SQL query to find the match number in which Germany played against Poland. Group the result set on match number. Return match number.
SELECT match_no,
       COUNT(team_id) 
FROM match_details
WHERE team_id IN (SELECT country_id
                  FROM soccer_country
                  WHERE country_name IN ('Poland', 'Germany'))
HAVING COUNT(team_id) / 4 = 2;

-- 5. From the following tables, write a SQL query to find the result of the match where Portugal played against Hungary. Return match_no, play_stage, play_date, results, goal_score. 
SELECT match_no,
       play_stage,
       play_date,
       results,
       goal_score
FROM match_mast
WHERE match_no IN (SELECT det.match_no
	           FROM match_details det
	           JOIN soccer_country count ON det.team_id = count.country_id
	           WHERE count.country_name IN ('Portugal', 'Hungary')
	           GROUP BY det.match_no
	           HAVING COUNT(det.team_id)/4 = 2);

-- 6. From the following tables, write a SQL query to find those players who scored number of goals in every match. Group the result set on match number, country name and player name. 
--    Sort the result-set in ascending order by match number. Return match number, country name, player name and number of matches.
SELECT det.match_no,
       count.country_name,
       mast.player_name,
       COUNT(det.goal_id)
FROM goal_details det
JOIN soccer_country count ON det.team_id = count.country_id
JOIN player_mast mast ON det.player_id = mast.player_id
GROUP BY det.match_no,
         count.country_name,
         mast.player_name
ORDER BY det.match_no 


-- 7. From the following tables, write a SQL query to find the highest audience match. Return country name of the teams.
SELECT count.country_name
FROM soccer_country count
JOIN goal_details det ON count.country_id = det.team_id
JOIN match_mast mast ON det.match_no = mast.match_no
WHERE mast.audence = (SELECT MAX(audence)
		      FROM match_mast);


-- 8. From the following tables, write a SQL query to find the player who scored the last goal for Portugal against Hungary. Return player name.
WITH port_hung_match AS (
SELECT det.match_no
FROM match_details det
JOIN soccer_country count ON det.team_id = count.country_id
WHERE count.country_name IN ('Portugal', 'Hungary')
GROUP BY det.match_no
HAVING COUNT(det.team_id)/4 = 2
)

SELECT mast.player_name
FROM player_mast mast
JOIN goal_details det ON mast.player_id = det.player_id 
WHERE det.match_no IN (SELECT match_no 
                       FROM port_hung_match)
      AND mast.team_id = (SELECT country_id
			  FROM soccer_country
			  WHERE country_name = 'Portugal')
      AND det.goal_id = (SELECT MAX(goal_id)
		         FROM goal_details
			 WHERE match_no IN (SELECT match_no 
					    FROM port_hung_match));

-- 9. From the following table, write a SQL query to find the second-highest stoppage time, which had been added, in the second half of play. 
SELECT MAX(stop2_sec)
FROM (SELECT stop2_sec
      FROM match_mast
      WHERE stop2_sec <> (SELECT MAX(stop2_sec)
			  FROM match_mast)) a;

			  
-- 10. From the following tables, write a SQL query to find the teams played the match where second highest stoppage time had been added in second half of play. Return country name of the teams.    
WITH secmax_stop2 AS (
SELECT stop2_sec
FROM match_mast
WHERE stop2_sec <> (SELECT MAX(stop2_sec)
		    FROM match_mast) 
) 

SELECT count.country_name
FROM soccer_country count 
JOIN match_details det ON count.country_id = det.team_id
JOIN match_mast mast ON det.match_no = mast.match_no
WHERE mast.stop2_sec = (SELECT MAX(stop2_sec)
			FROM secmax_stop2);

-- 11. From the following table, write a SQL query to find the teams played the match where second highest stoppage time had been added in second half of play. Return match_no, play_date, stop2_sec.		
WITH secmax_stop2 AS (
SELECT stop2_sec
FROM match_mast
WHERE stop2_sec <> (SELECT MAX(stop2_sec)
		    FROM match_mast) 
) 

SELECT match_no,
       play_date,
       stop2_sec
FROM match_mast
WHERE stop2_sec = (SELECT MAX(stop2_sec)
		   FROM secmax_stop2);

-- 12. From the following tables, write a SQL query to find the team, which was defeated by Portugal in EURO cup 2016 final. Return the country name of the team.
SELECT DISTINCT count_b.country_name
FROM soccer_country count_a
JOIN match_details det_a ON count_a.country_id = det_a.team_id
JOIN match_details det_b ON det_a.match_no = det_b.match_no 
                            AND det_a.team_id <> det_b.team_id
JOIN soccer_country count_b ON det_b.team_id = count_b.country_id
WHERE det_a.team_id = (SELECT country_id
		       FROM soccer_country
		       WHERE country_name = 'Portugal')
       AND det_a.win_lose = 'W'
       AND det_a.match_no = (SELECT MAX(match_no)
                             FROM match_details);
                             
-- 13. From the following table, write a SQL query to find the club, which supplied the most number of players to the 2016-EURO cup. Return club name, number of players. 
WITH clubmem_count(club, player_count) AS (
SELECT playing_club,
       COUNT(player_id)
FROM player_mast
GROUP BY playing_club
)

SELECT club,
       player_count 
FROM clubmem_count
WHERE player_count = (SELECT MAX(player_count)
		      FROM clubmem_count);

-- 14. From the following tables, write a SQL query to find the player who scored the first penalty of the tournament. Return player name and Jersey number.
WITH penalty_info AS (
SELECT *
FROM goal_details
WHERE goal_type = 'P'
)

SELECT mast.player_name,
       mast.jersey_no
FROM player_mast mast 
JOIN penalty_info pen ON mast.player_id = pen.player_id
WHERE pen.goal_id = (SELECT MIN(goal_id)
		     FROM penalty_info);

-- 15. From the following tables, write a SQL query to find the player who scored the first penalty in the tournament. Return player name, Jersey number and country name. 		     
WITH penalty_info AS (
SELECT *
FROM goal_details
WHERE goal_type = 'P'
)

SELECT mast.player_name,
       mast.jersey_no,
       count.country_name
FROM player_mast mast 
JOIN penalty_info pen ON mast.player_id = pen.player_id
JOIN soccer_country count ON mast.team_id = count.country_id
WHERE pen.goal_id = (SELECT MIN(goal_id)
		     FROM penalty_info);

-- 16. From the following tables, write a SQL query to find the goalkeeper for Italy in penalty shootout against Germany in Football EURO cup 2016. Return goalkeeper name.
SELECT mast.player_name
FROM player_mast mast
JOIN penalty_gk gk ON mast.player_id = gk.player_gk
JOIN soccer_country count ON gk.team_id = count.country_id
WHERE count.country_name = 'Italy';

-- 17. From the following tables, write a SQL query to find the number of goals Germany scored at the tournament.
SELECT COUNT(det.goal_id)
FROM goal_details det
JOIN soccer_country count ON det.team_id = count.country_id
WHERE count.country_name = 'Germany';

-- 18. From the following tables, write a SQL query to find the players who were the goalkeepers of England squad in 2016-EURO cup. Return player name, jersey number, club name.
SELECT player_name,
       jersey_no,
       playing_club
FROM player_mast
WHERE team_id = (SELECT country_id 
                 FROM soccer_country
		 WHERE country_name = 'England') 
      AND posi_to_play = 'GK';
      
-- 19. From the following tables, write a SQL query to find the players under contract to Liverpool were in the Squad of England in 2016-EURO cup. Return player name, jersey number, position to play, age. 
SELECT player_name,
       jersey_no, 
       posi_to_play,
       age
FROM player_mast
WHERE team_id = (SELECT country_id 
                 FROM soccer_country
		 WHERE country_name = 'England') 
      AND playing_club = 'Liverpool';

-- 20. From the following tables, write a SQL query to find the players who scored the last goal in the 2nd semi-final, i.e., 50th match in EURO cup 2016. Return player name, goal time, goal half, country name.   
SELECT player.player_name,
       det.goal_time,
       det.goal_half,
       count.country_name
FROM player_mast player
JOIN goal_details det ON player.player_id = det.player_id
JOIN soccer_country count ON player.team_id = count.country_id
WHERE det.match_no = 50
      AND det.goal_half = 2;

-- 21. From the following tables, write a SQL query to find the captain of the EURO cup 2016 winning team from Portugal. Return the captain name.
SELECT DISTINCT player.player_name
FROM player_mast player
JOIN match_captain cap ON player.player_id = cap.player_captain
			  AND player.team_id = cap.team_id
JOIN match_details det ON cap.match_no = det.match_no
			  AND cap.team_id = det.team_id
WHERE det.match_no = (SELECT MAX(match_no)
		      FROM match_details)
      AND det.win_lose = 'W';

-- 22. From the following tables, write a SQL query to count the number of players played for 'France’ in the final. Return 'Number of players shared fields'.
SELECT COUNT(DISTINCT player.player_id) + 11 AS "Number of players shared fields"
FROM player_in_out player
JOIN match_mast match ON player.match_no = match.match_no
JOIN soccer_country count ON player.team_id = count.country_id
WHERE match.play_stage = 'F'
      AND in_out = 'I'
      AND count.country_name = 'France';		 

-- 23. From the following tables, write a SQL query to find the Germany goalkeeper who didn't concede any goal in their group stage matches. Return goalkeeper name, jersey number. 
SELECT player.player_name,
       player.jersey_no
FROM player_mast player
JOIN match_details det ON player.team_id = det.team_id
		          AND player.player_id = det.player_gk
JOIN soccer_country count ON player.team_id = count.country_id
WHERE count.country_name = 'Germany' 
      AND det.goal_score = 0;

-- 24. From the following tables, write a SQL query to find the runners-up in Football EURO cup 2016. Return country name.
SELECT count.country_name
FROM soccer_country count
JOIN match_details det ON count.country_id = det.team_id
WHERE det.play_stage = 'F'   
      AND det.win_lose = 'L';

-- 25. From the following tables, write a SQL query to find the maximum penalty shots taken by the teams. Return country name, maximum penalty shots. 
WITH pen_count(team_id, penalty_n) AS (
SELECT team_id,
       COUNT(*)
FROM penalty_shootout
GROUP BY team_id
)

SELECT count.country_name,
       pen.penalty_n AS "Maximum penalty shots"
FROM soccer_country count
JOIN pen_count pen ON count.country_id = pen.team_id
WHERE pen.penalty_n = (SELECT MAX(penalty_n)
		       FROM pen_count);

-- 26. From the following tables, write a SQL query to find the maximum number of penalty shots taken by the players. Return country name, player name, jersey number and number of penalty shots.
WITH playerpen_count(player_id, penalty_n) AS (
SELECT player_id,
       COUNT(*)
FROM penalty_shootout
GROUP BY player_id
)

SELECT count.country_name,
       player.player_name,
       player.jersey_no,
       pen.penalty_n AS "Number of penalty shots"
FROM player_mast player
JOIN playerpen_count pen ON player.player_id = pen.player_id
JOIN soccer_country count ON player.team_id = count.country_id
WHERE pen.penalty_n = (SELECT MAX(penalty_n)
		     FROM playerpen_count); 

-- 27. From the following table, write a SQL query to find those match where the highest number of penalty shots taken. 
WITH shots_n(match_no, shots) AS (
SELECT match_no,
       COUNT(*) 
FROM penalty_shootout
GROUP BY match_no
)

SELECT *
FROM shots_n 
WHERE shots = (SELECT MAX(shots)
	       FROM shots_n);
      
-- 28. From the following table, write a SQL query to find the match number where highest number of penalty shots had been taken. Return match number, country name.
WITH shots_n(match_no, shots) AS (
SELECT match_no,
       COUNT(*) 
FROM penalty_shootout
GROUP BY match_no
)

SELECT DISTINCT shots_n.*,
       count.country_name
FROM shots_n
JOIN penalty_shootout pen ON shots_n.match_no = pen.match_no
JOIN soccer_country count ON pen.team_id = count.country_id
WHERE shots_n.shots = (SELECT MAX(shots)
		       FROM shots_n) 

-- 29. From the following tables, write a SQL query to find the player of 'Portugal' who taken the seventh kick against 'Poland'. Return match number, player name and kick number. 
SELECT pen.match_no,
       player.player_name,
       pen.kick_no
FROM penalty_shootout pen
JOIN player_mast player ON pen.player_id = player.player_id
JOIN soccer_country count ON pen.team_id = count.country_id
WHERE pen.kick_no = 7
      AND count.country_name = 'Portugal';

-- 30. From the following tables, write a SQL query to find the stage of match where penalty kick number 23 had been taken. Return match number, play_stage.
SELECT pen.match_no,
       match.play_stage
FROM penalty_shootout pen
JOIN match_mast match ON pen.match_no = match.match_no
WHERE pen.kick_id = 23;

-- 31. From the following tables, write a SQL query to find the venues where penalty shoot-out matches played. Return venue name.
SELECT DISTINCT venue.venue_name
FROM soccer_venue venue
JOIN match_mast match ON venue.venue_id = match.venue_id
JOIN penalty_shootout pen ON match.match_no = pen.match_no;

-- 32. From the following tables, write a SQL query to find the date when penalty shootout matches played. Return playing date.
SELECT DISTINCT match.play_date
FROM match_mast match
JOIN penalty_shootout pen ON match.match_no = pen.match_no;

-- 33. From the following table, write a SQL query to find the quickest goal at the EURO cup 2016, after 5 minutes. Return 'Quickest goal after 5 minutes'.
SELECT MIN(goal_time) AS "Quickest goal after 5 minutes"
FROM goal_details
WHERE goal_time > 5;


