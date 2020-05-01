#!/bin/bash
java -jar ./DynamoDBLocal.jar -inMemory >> logs 2>&1 &
/init-scripts.sh >> logs 2>&1 &
tail -f logs