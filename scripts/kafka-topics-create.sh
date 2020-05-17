#!/bin/bash
kafka-topics --create --topic $1 --partitions 3 --replication-factor 1 --zookeeper kafka-cluster:2181