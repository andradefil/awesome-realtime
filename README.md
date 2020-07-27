# awesome-realtime
Example of a stream processor application with kafka and ksqldb using a scenario of a real time multiplayer shooter game.

## Architecture
JsShooter game backend produces messages on kafka topics: `game_updates` and `players`, the messages is processed from kafka topics using ksqldb streams, tables and materialized views. The messages in kafka topics follow the below formats:

topic: **game_updates**

```
Key:         8be92e94 (user id)
Partition:   0
Offset:      14425
Timestamp:   2020-07-26 16:16:34.377 -0300 -03
{
  "doubleBulletSize": false,
  "doubleFireSpeed": false,
  "dualBullets": false,
  "hp": 10,
  "playerId": "8be92e94",
  "quadrupleBullets": false,
  "quadrupleFireSpeed": false,
  "score": 1249,
  "upgHP": 500
}

```
topic: **players**

```
Key:         250c4d3a (user id)
Partition:   0
Offset:      20
Timestamp:   2020-07-26 18:45:54.214 -0300 -03
{
  "connected": true,
  "id": "250c4d3a",
  "name": "Awesome Player"
}
```

## Hands On

Innitialize the components:
```bash
docker-compose up
```

Connect in ksql-server:
```bash
docker run --rm -it --net=awesome-realtime_default confluentinc/ksqldb-cli:0.10.1 ksql http://ksqldb-server:8088
```

If all is correct the "default" topic will be available in the command

```
ksql> show topics;

 Kafka Topic                 | Partitions | Partition Replicas 
---------------------------------------------------------------
 default_ksql_processing_log | 1          | 1                  
---------------------------------------------------------------


```

Lets access our JsShooter game, kill some NPC's and back to kafka, the game must be available in the URL http://localhost:8080

Now the topics `game_updates` and `players` should be available.

```
ksql> show topics;

 Kafka Topic                 | Partitions | Partition Replicas 
---------------------------------------------------------------
 default_ksql_processing_log | 1          | 1                  
 game_updates                | 1          | 1                  
 players                     | 1          | 1                  
---------------------------------------------------------------

```

Lets see the topics content

```
ksql> print game_updates from beginning;
Key format: KAFKA_BIGINT or KAFKA_DOUBLE or KAFKA_STRING
Value format: JSON or KAFKA_STRING
rowtime: 2020/07/26 23:40:55.647 Z, key: 7365694602338461236, value: {"playerId":"f8478ef4","hp":10,"upgHP":500,"score":0,"doubleBulletSize":false,"doubleFireSpeed":false,"quadrupleFireSpeed":false,"quadrupleBullets":false,"dualBullets":false}
rowtime: 2020/07/26 23:40:55.914 Z, key: 7365694602338461236, value: {"playerId":"f8478ef4","hp":10,"upgHP":500,"score":0,"doubleBulletSize":false,"doubleFireSpeed":false,"quadrupleFireSpeed":false,"quadrupleBullets":false,"dualBullets":false}
rowtime: 2020/07/26 23:40:56.180 Z, key: 7365694602338461236, value: 
....
```

```
ksql> print players from beginning;
Key format: KAFKA_BIGINT or KAFKA_DOUBLE or KAFKA_STRING
Value format: JSON or KAFKA_STRING
rowtime: 2020/07/26 23:36:50.452 Z, key: 7291669063579887159, value: {"id":"e16abbf7","name":"Awesome Player","connected":true}
rowtime: 2020/07/26 23:36:50.357 Z, key: 7291669063579887159, value: {"id":"e16abbf7","name":"Unnamed","connected":true}
rowtime: 2020/07/26 23:40:36.873 Z, key: 7291669063579887159, value: {"id":"e16abbf7","name":"Awesome Player","connected":false}
rowtime: 2020/07/26 23:40:54.997 Z, key: 7365694602338461236, value: {"id":"f8478ef4","name":"Unnamed","connected":true}
rowtime: 2020/07/26 23:40:55.073 Z, key: 7365694602338461236, value: {"id":"f8478ef4","name":"Awesome Player","connected":true}
rowtime: 2020/07/26 23:40:59.204 Z, key: 7365694602338461236, value: {"id":"f8478ef4","name":"Awesome Player","connected":false}
....
```

Now that we have our data sent to Kafka by our JsShooter game lets create some data streams. In KSQL console we will create the base data stream `game_updates` to be used to process stream data and `players` table to be used of reference of player data.

```
ksql> CREATE STREAM game_updates (\
>playerId VARCHAR KEY, \
>hp INT, \
>name VARCHAR, \
>upgHP INT, \
>score INT, \
>doubleBulletSize BOOLEAN, \
>doubleFireSpeed BOOLEAN, \
>quadrupleFireSpeed BOOLEAN, \
>quadrupleBullets BOOLEAN, \
>dualBullets BOOLEAN) \
>WITH (VALUE_FORMAT='JSON', KAFKA_TOPIC='game_updates');

 Message        
----------------
 Stream created 
----------------
```

```
ksql> CREATE TABLE players (\
>id VARCHAR PRIMARY KEY, \
>name VARCHAR, \
>connected BOOLEAN \
>) WITH (VALUE_FORMAT='JSON', KAFKA_TOPIC='players');

 Message       
---------------
 Table created 
---------------
```

You can ensure that all was created successfully with commands
```
ksql> show streams;

 Stream Name         | Kafka Topic                 | Format 
------------------------------------------------------------
 GAME_UPDATES        | game_updates                | JSON   
 KSQL_PROCESSING_LOG | default_ksql_processing_log | JSON   
------------------------------------------------------------

ksql> show tables;

 Table Name | Kafka Topic | Format | Windowed 
----------------------------------------------
 PLAYERS    | players     | JSON   | false    
----------------------------------------------
```

With theese streams of data and table created we can visualize the game data in real time.

```
ksql> select * from game_updates emit changes;

ksql> select * from players emit changes;
```

This is the basic structure to begin the stream processing, in the KSQLDB we manipulates events deriving new collections from old existing collections, in our case are `game_updates stream` and `players table`, the critical part of stream processing applications is transform, filter, join and aggregate events, so, the default pattern in KSQLDB for stream processing is to create a new collection using the `SELECT` statement in a existing collection. You don't need to declare a schema when derives from an existent collection. Let's create a new collection to know the game metrics.

```
ksql> CREATE table player_interactions AS
>    SELECT p.id AS player_id, COUNT(*) AS interactions
>    FROM game_updates g JOIN players p ON p.id = g.playerId
>    GROUP BY p.id EMIT CHANGES;

 Message                                          
--------------------------------------------------
 Created query with ID CTAS_PLAYER_INTERACTIONS_0 
--------------------------------------------------


ksql> CREATE TABLE game_metrics AS
>    SELECT p.id, p.name, pi.interactions
>    FROM player_interactions pi JOIN players p ON p.id = pi.player_id
>    EMIT CHANGES;

 Message                                   
-------------------------------------------
 Created query with ID CTAS_GAME_METRICS_7 

```

With this we can to know the game metrics, interactions from players.

```
ksql> select * from game_metrics emit changes;
```

We can explore too the materialized views, we will create a materialized view to know the highscore of players.

```
ksql> CREATE TABLE players_highscore AS \
>    SELECT playerId, MAX(score) as highScore \
>    FROM game_updates \
>    GROUP BY playerId
>    EMIT CHANGES;

 Message                                        
------------------------------------------------
 Created query with ID CTAS_PLAYERS_HIGHSCORE_9 
------------------------------------------------
```

From materialized views we can use a PULL query to get the actual highscore using ksql HTTP API.
```
curl -s -X "POST" "http://localhost:8088/query" \
     -H "Content-Type: application/vnd.ksql.v1+json; charset=utf-8" \
     -d $'{
            "ksql": "select * from players_highscore where playerId = \'67af5ae2\';",
            "streamsProperties": {}
            }' | jq
[
  {
    "header": {
      "queryId": "query_1595818540328",
      "schema": "`PLAYERID` STRING KEY, `HIGHSCORE` INTEGER"
    }
  },
  {
    "row": {
      "columns": [
        "67af5ae2",
        1150
      ]
    }
  }
]

```





