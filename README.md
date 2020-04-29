# awesome-realtime
POC getting real-time data streams from SNS topic and put data into Kafka ending up into DynamoDB

Architecture Big Picture
![architecture big picture](docs/bigpicture.png "Architecture Big Picture")

## SNS as source of processor

> On AWS using SNS to fan out to multiple SQS queues is a common scenario. SNS fan out means creating a SQS queue for each consumer of an SNS message and subscribing each SQS queue to the SNS topic. This means when a message is sent to the SNS topic a copy of the message arrives in each consumer’s queue. It gives you multicast messaging and the ability to consume messages at your own pace and allowing you to not be online when a notification occurs.

## DynamoDB as storage
> Dynamodb has high performance as storage (... continue) 

Stack
* SNS 
* SQS
* Apache Kafka + Kafka Connectors
* DynamoDB

The local setup to run is based in docker-compose

## Run
> docker-compose up --build

References:
> https://www.confluent.io/hub/confluentinc/kafka-connect-sqs (sqs plugin )

> https://kevinholditch.co.uk/2017/10/19/running-sns-sqs-locally-in-docker-containers-supporting-fan-out/ (article that inspired docker-compose stack)