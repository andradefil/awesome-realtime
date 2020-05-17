#!/bin/bash
docker run --rm -it --net=awesome-realtime_default  confluentinc/ksqldb-cli:0.8.1 ksql http://ksqldb-server:8088