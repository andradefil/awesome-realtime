:' 
CREATE TABLE players (\
id VARCHAR PRIMARY KEY, \
name VARCHAR, \
connected BOOLEAN \
) WITH (VALUE_FORMAT='JSON', KAFKA_TOPIC='players');