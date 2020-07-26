:'

// Wrong Query - Lost reference when player change name

CREATE TABLE game_metrics AS
    SELECT p.id, p.name, COUNT(*) AS interactions
    FROM game_updates g JOIN players p ON p.id = g.playerId
    GROUP BY p.id, p.name EMIT CHANGES;


// Right Query - Get game metrics from pre-calculated data from player_interactions

CREATE table player_interactions AS
    SELECT p.id AS player_id, COUNT(*) AS interactions
    FROM game_updates g JOIN players p ON p.id = g.playerId
    GROUP BY p.id EMIT CHANGES;

CREATE TABLE game_metrics AS
    SELECT p.id, p.name, pi.interactions
    FROM player_interactions pi JOIN players p ON p.id = pi.player_id
    EMIT CHANGES;