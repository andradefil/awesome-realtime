#!/bin/bash
kafka-topics --delete --topic $1 --zookeeper kafka-cluster:2181