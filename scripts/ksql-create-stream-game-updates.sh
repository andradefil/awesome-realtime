:' 
CREATE STREAM game_updates (\
playerId VARCHAR KEY, \
hp INT, \
upgHP INT, \
score INT, \
doubleBulletSize BOOLEAN, \
doubleFireSpeed BOOLEAN, \
quadrupleFireSpeed BOOLEAN, \
quadrupleBullets BOOLEAN, \
dualBullets BOOLEAN) \
WITH (VALUE_FORMAT='JSON', KAFKA_TOPIC='game_updates');
