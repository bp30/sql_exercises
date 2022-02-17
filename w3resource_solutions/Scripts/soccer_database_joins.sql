/*
w3resource SQL exercises

Soccer database joins (61 exercises)
https://www.w3resource.com/sql-exercises/soccer-database-exercise/joins-exercises-on-soccer-database.php
*/

-- 1. From the following tables, write a SQL query to find the venue where EURO cup 2016 final match held. Return venue name, city.
SELECT venue.venue_name,
       city.city
FROM soccer_venue venue
JOIN match_mast match ON venue.venue_id = match.venue_id
JOIN soccer_city city ON venue.city_id = city.city_id
WHERE match.play_stage = 'F';

-- 2. From the following tables, write a SQL query to find the number of goal scored by each team in every match within normal play schedule. Return match number, country name and goal score. 
SELECT det.match_no,
       count.country_name,
       det.goal_score
FROM match_details det
JOIN soccer_country count ON det.team_id = count.country_id
WHERE decided_by = 'N';

-- 3. From the following tables, write a SQL query to count the number of goals scored by each player within normal play schedule. 
--    Group the result set on player name and country name and sorts the result-set according to the highest to the lowest scorer. Return player name, number of goals and country name.
SELECT player.player_name,
       COUNT(goal.goal_id),
       count.country_name
FROM player_mast player
JOIN goal_details goal ON player.player_id = goal.player_id
JOIN soccer_country count ON player.team_id = count.country_id
WHERE goal_schedule = 'NT'
GROUP BY player.player_name, count.country_name
ORDER BY COUNT(goal.goal_id) DESC;

-- 4. From the following tables, write a SQL query to find the highest individual scorer in EURO cup 2016. Return player name, country name and highest individual scorer. 
WITH goal_count(player_id, team_id, goal_n) AS (
SELECT player_id,
       team_id,
       COUNT(*)
FROM goal_details
GROUP BY player_id, team_id
)

SELECT player.player_name,
       count.country_name,
       COUNT(goal.goal_id)
FROM player_mast player
JOIN goal_details goal ON player.player_id = goal.player_id
JOIN soccer_country count ON player.team_id = count.country_id
GROUP BY player.player_name, count.country_name
HAVING COUNT(goal.goal_id) = (SELECT MAX(goal_n)
			      FROM goal_count);

-- 5. From the following tables, write a SQL query to find the scorer in the final of EURO cup 2016. Return player name, jersey number and country name. 
SELECT player.player_name,
       player.jersey_no,
       count.country_name
FROM player_mast player
JOIN goal_details goal ON player.player_id = goal.player_id
JOIN soccer_country count on player.team_id = count.country_id
WHERE play_stage = 'F';

-- 6. From the following tables, write a SQL query to find the country where Football EURO cup 2016 held. Return country name.
SELECT country_name
FROM soccer_country
WHERE country_id IN (SELECT country_id
		     FROM soccer_city);

-- 7. From the following tables, write a SQL query to find the player who scored first goal of EURO cup 2016. Return player_name, jersey_no, country_name, goal_time, play_stage, goal_schedule, goal_half.
SELECT player.player_name,
       player.jersey_no,
       count.country_name,
       goal.goal_time,
       goal.play_stage,
       goal.goal_schedule,
       goal.goal_half
FROM player_mast player
JOIN soccer_country count ON player.team_id = count.country_id
JOIN goal_details goal ON player.player_id = goal.player_id
WHERE goal.goal_id = 1;

-- 8. From the following tables, write a SQL query to find the referee who managed the opening match. Return referee name, country name.
SELECT ref.referee_name,
       count.country_name
FROM referee_mast ref
JOIN match_mast match ON ref.referee_id = match.referee_id
JOIN soccer_country count ON ref.country_id = count.country_id
WHERE match.match_no = 1;

-- 9. From the following tables, write a SQL query to find the referee who managed the final match. Return referee name, country name.
SELECT ref.referee_name,
       count.country_name
FROM referee_mast ref
JOIN match_mast match ON ref.referee_id = match.referee_id
JOIN soccer_country count ON ref.country_id = count.country_id
WHERE match.play_stage = 'F';

-- 10. From the following tables, write a SQL query to find the referee who assisted the referee in the opening match. Return associated referee name, country name. 
SELECT asst.ass_ref_name,
       count.country_name
FROM asst_referee_mast asst
JOIN match_details match ON asst.ass_ref_id = match.ass_ref
JOIN soccer_country count ON asst.country_id = count.country_id
WHERE match.match_no = 1;

-- 11. From the following tables, write a SQL query to find the referee who assisted the referee in the final match. Return associated referee name, country name.
SELECT asst.ass_ref_name,
       count.country_name
FROM asst_referee_mast asst
JOIN match_details match ON asst.ass_ref_id = match.ass_ref
JOIN soccer_country count ON asst.country_id = count.country_id
WHERE match.play_stage = 'F';


-- 12. From the following tables, write a SQL query to find the city where the opening match of EURO cup 2016 played. Return venue name, city.
SELECT ven.venue_name,
       city.city
FROM soccer_venue ven
JOIN soccer_city city ON ven.city_id = city.city_id
JOIN match_mast match ON ven.venue_id = match.venue_id
WHERE match.match_no = 1;

-- 13. From the following tables, write a SQL query to find the stadium hosted the final match of EURO cup 2016. Return venue_name, city, aud_capacity, audience. 
SELECT ven.venue_name,
       city.city,
       ven.aud_capacity,
       match.audence
FROM soccer_venue ven
JOIN soccer_city city ON ven.city_id = city.city_id
JOIN match_mast match ON ven.venue_id = match.venue_id
WHERE match.play_stage = 'F';

-- 14. From the following tables, write a SQL query to count the number of matches played in each venue. Sort the result-set on venue name. Return Venue name, city, and number of matches
SELECT ven.venue_name,
       city.city,
       COUNT(match.match_no)
FROM soccer_venue ven
JOIN soccer_city city ON ven.city_id = city.city_id
JOIN match_mast match ON ven.venue_id = match.venue_id
GROUP BY ven.venue_name, city.city
ORDER BY ven.venue_name;

-- 15. From the following tables, write a SQL query to find the player who was the first player to be sent off at the tournament EURO cup 2016. Return match Number, country name and player name. 
WITH player_off AS (
SELECT match_no,
       team_id,
       booking_time,
       play_schedule,
       player_id
FROM player_booked 
WHERE sent_off = 'Y'
)

SELECT off.match_no,
       count.country_name,
       player.player_name,
       off.booking_time AS sent_off_time,
       off.play_schedule,
       player.jersey_no
FROM player_mast player
JOIN player_off off ON player.player_id = off.player_id
JOIN soccer_country count ON player.team_id = count.country_id
WHERE off.match_no = (SELECT MIN(match_no)
                      FROM player_off);

-- 16. From the following tables, write a SQL query to find those teams that scored only one goal to the tournament. Return country_name as "Team", team in the group, goal_for.
SELECT count.country_name AS Team,
       team.team_group,
       team.goal_for
FROM soccer_team team
JOIN soccer_country count ON team.team_id = count.country_id
WHERE team.goal_for = 1;

-- 17. From the following tables, write a SQL query to count the yellow cards received by each country. Return country name and number of yellow cards
SELECT count.country_name,
       COUNT(booked.sent_off)
FROM player_booked booked
JOIN soccer_country count ON booked.team_id = count.country_id
GROUP BY count.country_name
ORDER BY COUNT(booked.sent_off) DESC; 

-- 18. From the following tables, write a SQL query to count number of goals that has seen. Return venue name and number of goals.                    
SELECT ven.venue_name,
       COUNT(goal.goal_id)
FROM soccer_venue ven
JOIN match_mast match ON ven.venue_id = match.venue_id
JOIN goal_details goal ON match.match_no = goal.match_no
GROUP BY ven.venue_id
ORDER BY COUNT(goal.goal_id) DESC;

-- 19. From the following tables, write a SQL query to find the match where no stoppage time added in first half of play. Return match number, country name.
SELECT match.match_no,
       count.country_name
FROM match_details match
JOIN match_mast mast ON match.match_no = mast.match_no
JOIN soccer_country count ON match.team_id = count.country_id
WHERE mast.stop1_sec = 0;

-- 20. From the following tables, write a SQL query to find the team(s) who conceded the most goals in EURO cup 2016. Return country name, team group and match played.
SELECT count.country_name,
       team.* 
FROM soccer_team team
JOIN soccer_country count ON team.team_id = count.country_id
WHERE team.goal_agnst = (SELECT MAX(goal_agnst)
                         FROM soccer_team);

-- 21. From the following tables, write a SQL query to find those matches where highest stoppage time added in 2nd half of play. Return match number, country name, stoppage time(sec.).
SELECT det.match_no,
       count.country_name,
       mast.stop2_sec
FROM match_details det
JOIN match_mast mast ON det.match_no = mast.match_no
JOIN soccer_country count ON det.team_id = count.country_id
WHERE mast.stop2_sec = (SELECT MAX(stop2_sec)
                        FROM match_mast);

-- 22. From the following tables, write a SQL query to find those matches ending with a goalless draw in-group stage of play. Return match number, country name.
SELECT match.match_no,
       count.country_name
FROM match_details match
JOIN soccer_country count ON match.team_id = count.country_id
WHERE match.goal_score = 0
      AND match.win_lose = 'D';

-- 23. From the following tables, write a SQL query to find those match(s) where the 2nd highest stoppage time had been added in the second half of play. Return match number, country name and stoppage time.
WITH sec_stop2 AS (
SELECT match_no,
       stop2_sec
FROM match_mast
WHERE stop2_sec < (SELECT MAX(stop2_sec)
		   FROM match_mast)
)

SELECT sec.match_no,
       count.country_name,
       sec.stop2_sec
FROM sec_stop2 sec
JOIN match_details det ON sec.match_no = det.match_no
JOIN soccer_country count ON det.team_id = count.country_id
WHERE sec.stop2_sec = (SELECT MAX(stop2_sec)
			FROM sec_stop2)

-- 24. From the following tables, write a SQL query to find the number of matches played a player as a goalkeeper for his team. Return country name, player name, number of matches played as a goalkeeper.
SELECT count.country_name,
       player.player_name,
       COUNT(match.match_no)       
FROM player_mast player
JOIN match_details match ON player.player_id = match.player_gk
JOIN soccer_country count ON player.team_id = count.country_id
GROUP BY count.country_name, player.player_name
ORDER BY count.country_name;

-- 25. From the following tables, write a SQL query to find the venue that has seen the most number of goals. Return venue name, number of goals.
WITH venue_goal (venue_name, goal_n) AS (
SELECT ven.venue_name,
       COUNT(goal.goal_id)
FROM soccer_venue ven
JOIN match_mast match ON ven.venue_id = match.venue_id
JOIN goal_details goal ON match.match_no = goal.match_no
JOIN soccer_country count ON goal.team_id = count.country_id
GROUP BY ven.venue_name
)

SELECT venue_name,
       goal_n
FROM venue_goal
WHERE goal_n = (SELECT MAX(goal_n)
                FROM venue_goal);

-- 26. From the following tables, write a SQL query to find the oldest player appeared in a EURO cup 2016 match. Return country name, player name, jersey number and age.
SELECT count.country_name,
       player.player_name,
       player.jersey_no,
       player.age
FROM player_mast player
JOIN soccer_country count ON player.team_id = count.country_id 
WHERE player.age = (SELECT MAX(age)
                    FROM player_mast);               

-- 27. From the following tables, write a SQL query to find those two teams, scored three goals in a single game in this tournament. Return match number and country name. 
SELECT det.match_no,
       count.country_name
FROM match_details det
JOIN soccer_country count ON det.team_id = count.country_id
WHERE det.goal_score = 3
      AND det.win_lose = 'D';

-- 28. From the following tables, write a SQL query to find those teams that finished bottom of their respective groups after conceding four times in three games. Return country name, team group and match played. 
SELECT count.country_name,
       team.team_group,
       team.match_played, 
       team.goal_agnst,
       team.group_position
FROM soccer_team team
JOIN soccer_country count ON team.team_id = count.country_id
WHERE team.group_position = 4
      AND team.goal_agnst = 4
      AND team.match_played = 3;

-- 29. From the following tables, write a SQL query to find those players, who contracted to ‘Lyon’ club and participated in the EURO cup 2016 Finals. Return player name, jerseyno, position to play, age, country name.
SELECT player.player_name,
       player.jersey_no,
       player.posi_to_play,
       player.age,
       count.country_name
FROM player_mast player
JOIN soccer_country count ON player.team_id = count.country_id
JOIN match_details match ON player.team_id = match.team_id    
WHERE player.playing_club = 'Lyon'
      AND match.play_stage = 'F';

-- 30. From the following tables, write a SQL query to find the final four teams in the tournament. Return country name
SELECT count.country_name
FROM soccer_country count
JOIN match_details match ON count.country_id = match.team_id
WHERE match.play_stage = 'S';

-- 31. From the following tables, write a SQL query to find the captains of the top four teams that participated in the semi-finals (match 48 and 49) in the tournament. Return country name, player name, jersey number and position to play. 
SELECT count.country_name,
       player.player_name,
       player.jersey_no,
       player.posi_to_play
FROM match_captain cap
JOIN player_mast player ON cap.player_captain = player.player_id
JOIN soccer_country count ON cap.team_id = count.country_id
WHERE cap.match_no IN (48, 49);

-- 32. From the following tables, write a SQL query to find the captains of all the matches in the tournament. Return match number, country name, player name, jersey number and position to play.
SELECT cap.match_no, 
       count.country_name,
       player.player_name,
       player.jersey_no,
       player.posi_to_play       
FROM match_captain cap
JOIN soccer_country count ON cap.team_id = count.country_id
JOIN player_mast player ON cap.player_captain = player.player_id;	

-- 33. From the following tables, write a SQL query to find the captain and goalkeeper of all the matches. Return match number, Captain, Goal Keeper and country name.
SELECT match.match_no,
       captain.player_name AS captain,
       gk.player_name AS goal_keep,
       count.country_name
FROM match_details match
JOIN match_captain cap ON match.match_no = cap.match_no
                          AND match.team_id = cap.team_id
JOIN player_mast gk ON match.player_gk = gk.player_id
JOIN player_mast captain ON cap.player_captain = captain.player_id
JOIN soccer_country count ON match.team_id = count.country_id
ORDER BY match.match_no;

-- 34. From the following tables, write a SQL query to find the player who was selected for the 'Man of the Match' award in the finals of EURO cup 2016.Return player name, country name.
SELECT player.player_name,
       count.country_name
FROM match_mast match 
JOIN player_mast player ON match.plr_of_match = player.player_id
JOIN soccer_country count ON player.team_id = count.country_id
WHERE match.play_stage = 'F';

-- 35. From the following tables, write a SQL query to find the substitute players who came into the field in the first half of play within normal play schedule. Return match_no, country_name, player_name, jersey_no and time_in_out.
SELECT sub.match_no,
       count.country_name,
       player.player_name,
       player.jersey_no,
       sub.time_in_out
FROM player_in_out sub
JOIN player_mast player ON sub.player_id = player.player_id
JOIN soccer_country count ON sub.team_id = count.country_id
WHERE sub.play_half = 1
      AND sub.play_schedule = 'NT'
      AND sub.in_out = 'I';

-- 36. From the following table, write a SQL query to prepare a list for the player of the match against each match. Return match number, play date, country name, player of the Match, jersey number. 
SELECT match.match_no,
       match.play_date,
       count.country_name,
       player.player_name,
       player.jersey_no
FROM match_mast match
JOIN player_mast player ON match.plr_of_match = player.player_id
JOIN soccer_country count ON player.team_id = count.country_id;

-- 37. From the following tables, write a SQL query to find the player who taken the penalty shot number 26. Return match number, country name, player name.
SELECT pen.match_no,
       count.country_name,
       player.player_name
FROM penalty_shootout pen
JOIN player_mast player ON pen.player_id = player.player_id
JOIN soccer_country count ON pen.team_id = count.country_id
WHERE pen.kick_id = 26;

-- 38. From the following tables, write a SQL query to find the team against which the penalty shot number 26 had been taken. Return match number, country name.
SELECT DISTINCT pen_a.match_no,
       count.country_name       
FROM penalty_shootout pen_a
JOIN penalty_shootout pen_b ON pen_a.match_no = pen_b.match_no
                               AND pen_a.team_id <> pen_b.team_id
JOIN soccer_country count ON pen_b.team_id = count.country_id
WHERE pen_a.kick_id = 26;

-- 39. From the following tables, write a SQL query to find the captain who was also the goalkeeper. Return match number, country name, player name and jersey number.
SELECT cap.match_no,
       count.country_name,
       player.player_name,
       player.jersey_no
FROM match_captain cap
JOIN player_mast player ON cap.player_captain = player.player_id
JOIN soccer_country count ON cap.team_id = count.country_id
WHERE player.posi_to_play = 'GK';

-- 40. From the following tables, write a SQL query to find the number of captains who was also the goalkeeper. Return number of captains.]
SELECT COUNT(DISTINCT player_id)
FROM match_captain cap
JOIN player_mast player ON cap.player_captain = player.player_id
WHERE player.posi_to_play = 'GK';

-- 41. From the following tables, write a SQL query to find the players along with their team booked number of times in the tournament. Show the result according to the team and number of times booked in descending order.
--     Return country name, player name, and team booked number of times. 
SELECT count.country_name,
       player.player_name,
       COUNT(*)
FROM player_booked book
JOIN soccer_country count ON book.team_id = count.country_id
JOIN player_mast player ON book.player_id = player.player_id
GROUP BY count.country_name,
         player.player_name
ORDER BY count.country_name, COUNT(*) DESC;

-- 42. From the following tables, write a SQL query to count the players who booked the most number of times. Return player name, number of players who booked most number of times.
WITH player_bookn AS (
SELECT player.player_name,
       COUNT(*) AS booked
FROM player_booked book
JOIN player_mast player ON book.player_id = player.player_id
GROUP BY player.player_name
)

SELECT *
FROM player_bookn
WHERE booked = (SELECT MAX(booked)
		FROM player_bookn);

-- 43. From the following tables, write a SQL query to find the number of players booked for each team. Return country name, number of players booked.	
SELECT count.country_name,
       COUNT(*) AS booked
FROM player_booked book
JOIN player_mast player ON book.player_id = player.player_id
JOIN soccer_country count ON book.team_id = count.country_id
GROUP BY count.country_name
ORDER BY COUNT(*) DESC;

-- 44. From the following tables, write a SQL query to find those matches where most number of cards shown. Return match number, number of cards shown.
WITH cards AS (
SELECT match_no,
       COUNT(*)/4 AS booked
FROM player_booked
GROUP BY match_no
)

SELECT *
FROM cards
WHERE booked = (SELECT MAX(booked)
		FROM cards);

-- 45. From the following table, write a SQL query to find the assistant referees. Return match number, country name, assistant referee name. 
SELECT match.match_no,
       count.country_name,
       asst.ass_ref_name
FROM match_details match
JOIN asst_referee_mast asst ON match.ass_ref = asst.ass_ref_id
JOIN soccer_country count ON match.team_id = count.country_id;

-- 46. From the following tables, write a SQL query to find the assistant referees of each country assists the number of matches. Sort the result-set in descending order on number of matches. Return country name, number of matches.
SELECT count.country_name,
       COUNT(DISTINCT match.match_no)
FROM match_details match
JOIN asst_referee_mast asst ON match.ass_ref = asst.ass_ref_id
JOIN soccer_country count ON asst.country_id = count.country_id
GROUP BY count.country_name
ORDER BY COUNT(DISTINCT match.match_no) DESC;	

-- 47. From the following table, write a SQL query to find the countries from where the assistant referees assist most of the matches. Return country name and number of matches.
WITH asst_matchn AS (
SELECT count.country_name,
       COUNT(DISTINCT match.match_no) AS assist_match
FROM match_details match
JOIN asst_referee_mast asst ON match.ass_ref = asst.ass_ref_id
JOIN soccer_country count ON asst.country_id = count.country_id
GROUP BY count.country_name
)

SELECT *
FROM asst_matchn
WHERE assist_match = (SELECT MAX(assist_match)
		      FROM asst_matchn);

-- 48. From the following table, write a SQL query to find the name of referees for each match. Sort the result-set on match number. Return match number, country name, referee name. 
SELECT match.match_no,
       count.country_name,
       ref.referee_name
FROM match_mast match
JOIN referee_mast ref ON match.referee_id = ref.referee_id
JOIN soccer_country count ON ref.country_id = count.country_id;	

-- 49. From the following tables, write a SQL query to count the number of matches managed by referees of each country. Return country name, number of matches.
SELECT count.country_name,
       COUNT(match.match_no)
FROM match_mast match
JOIN referee_mast ref ON match.referee_id = ref.referee_id
JOIN soccer_country count ON ref.country_id = count.country_id
GROUP BY count.country_name
ORDER BY COUNT(match.match_no) DESC;

-- 50. From the following tables, write a SQL query to find the countries from where the referees managed most of the matches. Return country name, number of matches.
WITH ref_matchn AS (
SELECT count.country_name,
       COUNT(match.match_no) AS match_n
FROM match_mast match
JOIN referee_mast ref ON match.referee_id = ref.referee_id
JOIN soccer_country count ON ref.country_id = count.country_id
GROUP BY count.country_name
)

SELECT *
FROM ref_matchn
WHERE match_n = (SELECT MAX(match_n)
		 FROM ref_matchn);

-- 51. From the following tables, write a SQL query to find the number of matches managed by each referee. Return referee name, country name, number of matches. 
SELECT ref.referee_name,
       count.country_name,
       COUNT(match.match_no)
FROM match_mast match
JOIN referee_mast ref ON match.referee_id = ref.referee_id
JOIN soccer_country count ON ref.country_id = count.country_id
GROUP BY ref.referee_name, count.country_name
ORDER BY COUNT(match.match_no) DESC;	

-- 52. From the following tables, write a SQL query to find those referees who managed most of the matches. Return referee name, country name and number of matches.
WITH ref_matchn AS (
SELECT ref.referee_name,
       count.country_name,
       COUNT(match.match_no) AS match_n
FROM match_mast match
JOIN referee_mast ref ON match.referee_id = ref.referee_id
JOIN soccer_country count ON ref.country_id = count.country_id
GROUP BY ref.referee_name, count.country_name
)

SELECT *
FROM ref_matchn
WHERE match_n = (SELECT MAX(match_n)
		 FROM ref_matchn)

-- 53. From the following tables, write a SQL query to find those referees who managed the number of matches in each venue. Return referee name, country name, venue name, number of matches.
SELECT ref.referee_name,
       count.country_name,
       ven.venue_name,
       COUNT(match.match_no)
FROM match_mast match
JOIN referee_mast ref ON match.referee_id = ref.referee_id
JOIN soccer_venue ven ON match.venue_id = ven.venue_id
JOIN soccer_country count ON ref.country_id = count.country_id
GROUP BY ref.referee_name,
         count.country_name,
         ven.venue_name
ORDER BY ref.referee_name;


-- 54. From the following tables, write a SQL query to find the referees and number of booked they made. Return referee name, number of matches. 
SELECT ref.referee_name,
       COUNT(*)
FROM match_mast match
JOIN player_booked book ON match.match_no = book.match_no
JOIN referee_mast ref ON match.referee_id = ref.referee_id
GROUP BY ref.referee_name
ORDER BY COUNT(*) DESC;

-- 55. From the following tables, write a SQL query to find those referees who booked most number of players. Return referee name, number of matches. 	
WITH ref_bookn AS (
SELECT ref.referee_name,
       COUNT(*)/4 AS bookn
FROM match_mast match
JOIN player_booked book ON match.match_no = book.match_no
JOIN referee_mast ref ON match.referee_id = ref.referee_id
GROUP BY ref.referee_name
)

SELECT *
FROM ref_bookn
WHERE bookn = (SELECT MAX(bookn)
	       FROM ref_bookn);

-- 56. From the following tables, write a SQL query to find those players of each team who wore jersey number 10. Return country name, player name, position to play, age and playing club.
SELECT count.country_name,
       player.player_name,
       player.posi_to_play,
       player.age,
       player.playing_club
FROM player_mast player
JOIN soccer_country count ON player.team_id = count.country_id
WHERE player.jersey_no = 10;

-- 57. From the following tables, write a SQL query to find those defenders who scored goal for their team. Return player name, jersey number, country name, age and playing club.
SELECT player.player_name,
       player.jersey_no,
       count.country_name,
       player.age,
       player.playing_club
FROM goal_details goal
JOIN player_mast player ON goal.player_id = player.player_id
JOIN soccer_country count ON goal.team_id = count.country_id
WHERE player.posi_to_play = 'DF'
ORDER BY player.player_name;

-- 58. From the following table, write a SQL query to find those players who accidentally scores against his own team. Return player name, jersey number, country name, age, position to play, and playing club.
SELECT player.player_name,
       player.jersey_no,
       count.country_name,
       player.age,
       player.posi_to_play,
       player.playing_club
FROM goal_details goal
JOIN player_mast player ON goal.player_id = player.player_id
JOIN soccer_country count ON goal.team_id = count.country_id
WHERE goal.goal_type = 'O';

-- 59. From the following table, write a SQL query to find the results of penalty shootout matches. Return match number, play stage, country name and penalty score. 
SELECT match.match_no,
       match.play_stage,
       count.country_name,
       match.penalty_score
FROM match_details match
JOIN soccer_country count ON match.team_id = count.country_id	
WHERE match.decided_by = 'P';      

-- 60. From the following table, write a SQL query to find the goal scored by the players according to their playing position. Return country name, position to play, number of goals.
SELECT count.country_name,
       player.posi_to_play,
       COUNT(goal.goal_id)
FROM player_mast player
JOIN goal_details goal ON player.player_id = goal.player_id
JOIN soccer_country count ON player.team_id = count.country_id
GROUP BY count.country_name,
         player.posi_to_play
ORDER BY count.country_name;

-- 61. From the following tables, write a SQL query to find those players who came into the field at the last time of play. Return match number, country name, player name, jersey number and time in out. 
SELECT in_out.match_no,
       count.country_name,
       player.player_name,
       player.jersey_no,
       in_out.time_in_out
FROM player_in_out in_out
JOIN player_mast player ON in_out.player_id = player.player_id
JOIN soccer_country count ON in_out.team_id = count.country_id
WHERE in_out.time_in_out = (SELECT MAX(time_in_out)
			    FROM player_in_out)
      AND in_out = 'I';
