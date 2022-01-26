/*
Section 6: the JOIN operation
https://sqlzoo.net/wiki/The_JOIN_operation
*/

-- 1. The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime
--    Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player 
FROM goal 
WHERE teamid = 'GER';

-- 2. From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.
--    Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.
--    Show id, stadium, team1, team2 for just game 1012
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

-- 3. You can combine the two steps into a single query with a JOIN.
--    The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say
--    ON (game.id=goal.matchid)
--    The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
--    Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT y.player, y.teamid, x.stadium, x.mdate
FROM game x
JOIN goal y ON x.id = y.matchid
WHERE y.teamid = 'GER';

-- 4. Use the same JOIN as in the previous question.
--    Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT x.team1, x.team2, y.player
FROM game x
JOIN goal y ON x.id = y.matchid
WHERE y.player LIKE 'Mario%';

-- 5. The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
--    Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT y.player, y.teamid, z.coach, y.gtime
FROM goal y
JOIN eteam z ON y.teamid = z.id
WHERE y.gtime <= 10;

-- 6. To JOIN game with eteam you could use either game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)
--    Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
--    List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach
SELECT x.mdate, z.teamname
FROM game x
JOIN eteam z ON x.team1 = z.id
WHERE z.coach = 'Fernando Santos';

-- 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT y.player
FROM goal y
JOIN game x ON x.id = y.matchid
WHERE x.stadium = 'National Stadium, Warsaw';

-- 8. The example query shows all goals scored in the Germany-Greece quarterfinal.
--    Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT y.player
FROM game x
JOIN goal y ON x.id = y.matchid
WHERE (x.team1 = 'GER' OR x.team2 = 'GER') AND y.teamid <> 'GER';

-- 9. Show teamname and the total number of goals scored.
SELECT z.teamname, COUNT(y.player) as total_scored
FROM goal y 
JOIN eteam z ON y.teamid = z.id
GROUP BY z.teamname;

-- 10. Show the stadium and the number of goals scored in each stadium.
SELECT x.stadium, COUNT(y.player) as total_goals
FROM game x
JOIN goal y ON x.id = y.matchid
GROUP BY x.stadium;

-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT y.matchid AS match_id, x.mdate AS date, COUNT(y.teamid) AS total_goals
FROM game x
JOIN goal y ON x.id = y.matchid
WHERE (team1 = 'POL' or team2 = 'POL')
GROUP BY y.matchid, x.mdate;

-- 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(teamid) 
FROM game
JOIN goal ON matchid = id
WHERE teamid = 'GER' 
GROUP BY matchid, mdate;

-- 13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
--     Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
SELECT x.mdate, 
       x.team1, SUM(CASE WHEN y.teamid = x.team1 THEN 1 ELSE 0 END) AS score1,
       x.team2, SUM(CASE WHEN y.teamid = x.team2 THEN 1 ELSE 0 END) AS score2
FROM game x
LEFT JOIN goal y ON x.id = y.matchid
GROUP BY x.mdate, x.team1, x.team2
ORDER BY x.mdate, y.matchid, x.team1, x.team2;

