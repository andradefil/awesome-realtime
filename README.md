# awesome-realtime
POC getting real-time data events from Js Shooter Game, generating data streams and performs query using ksql.

## Data generation
The data generation is made using automated bots that play the game dynamic data, I created a bot to jsShooter called `jsShooterBot`. To run go to directory jsShooterBot and run `node app.js`.

After run the bots will start and the battle begins:
<img src="./docs/bots-battle.gif" width="500">

The data will be sent for kafka by backend.

## Streams
```
ksql> select * from playerstream emit changes;
+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+
|ROWKEY             |ID                 |HP                 |NAME               |UPGHP              |SCORE              |DOUBLEBULLETSIZE   |DOUBLEFIRESPEED    |QUADRUPLEFIRESPEED |QUADRUPLEBULLETS   |DUALBULLETS        |
+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+-------------------+
|null               |0.11180612068519369|10                 |Lance Bot          |500                |211                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |180                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |6                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |
|null               |0.11180612068519369|10                 |Lance Bot          |500                |261                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |180                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |6                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |
|null               |0.11180612068519369|10                 |Lance Bot          |500                |261                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |180                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |5                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |
|null               |0.11180612068519369|10                 |Lance Bot          |500                |261                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |180                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |5                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |
|null               |0.11180612068519369|10                 |Lance Bot          |500                |311                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |230                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |5                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |
|null               |0.11180612068519369|10                 |Lance Bot          |500                |361                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |230                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |5                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |
|null               |0.11180612068519369|10                 |Lance Bot          |500                |361                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |230                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |4                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |
|null               |0.11180612068519369|10                 |Lance Bot          |500                |361                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |230                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |4                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |
|null               |0.11180612068519369|10                 |Lance Bot          |500                |361                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |230                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |4                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |
|null               |0.11180612068519369|10                 |Lance Bot          |500                |361                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |230                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |5                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |
|null               |0.11180612068519369|10                 |Lance Bot          |500                |361                |false              |false              |false              |false              |false              |
|null               |0.7508704367602033 |10                 |Neva Bot           |500                |601                |false              |false              |false              |false              |false              |
|null               |0.7898112422518919 |10                 |Travis Bot         |500                |230                |false              |false              |false              |false              |false              |
|null               |0.2768878019064893 |4                  |Beverly Bot        |500                |380                |false              |false              |false              |false              |false              |

```


Stack
* SNS 
* SQS
* Apache Kafka + Kafka Connectors
* DynamoDB

The local setup to run is based in docker-compose


Ports
* SNS : 9911
* SQS : 9324
* SQS-UI: 9325
* Zookeeper: 2181
* Landoop UI: 3030
* Rest Proxy, Schema Registry: 8081, 8083
* JMX Ports: 9581, 9585
* Kafka Broker: 9092
* DynamoDB: 8000

## Run
> docker-compose up --build

References:
* [SQS Connector Plugin](https://www.confluent.io/hub/confluentinc/kafka-connect-sqs)
* [Local SQS](https://github.com/roribio/alpine-sqs)
* [Local SNS](https://github.com/s12v/sns)
* [Local DynamoDB](https://hub.docker.com/r/amazon/dynamodb-local/)
* [Local Apache Kafka](https://hub.docker.com/r/landoop/fast-data-dev/)