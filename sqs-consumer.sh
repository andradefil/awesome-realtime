#!/bin/bash

while true
do 
    aws sqs --region us-east-1 --endpoint-url http://localhost:9324 receive-message --queue-url http://localhost:9324/queue/stream_processing
done
