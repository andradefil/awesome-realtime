:'
CREATE TABLE players_highscore AS \
    SELECT playerId, MAX(score) as highScore \
    FROM game_updates \
    GROUP BY playerId
    EMIT CHANGES;


// Query the materialized view
select * from players_highscore where playerId = '250c4d3a';
