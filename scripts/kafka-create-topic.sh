#!/bin/bash
kafka-topics --create --topic $1 --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181