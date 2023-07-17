---
title: Kafka vs RabbitMQ
date: 2022-07-18
math: true
featured: false
authors: admin
tags: 
 - rabbit-mq
 - kafka
categories: 
 - blog 
---
- [RabbitMQ](#rabbitmq)
- [Kafka](#kafka)
- [RabbitMQ Architecture](#rabbitmq-architecture)
- [Kafka Architecture](#kafka-architecture)
- [Use cases](#use-cases)
- [References](#references)

## RabbitMQ 
- supports : 
  - AMQP  : Advanced Message Queuing Protocol
  - MQTT  : MQ Telemetry Protocol
  - STOMP : Streaming Text Oriented Messaging Protocol
- is known as a *hybrid* broker
- uses *smart broker/dumb consumer* model
  
## Kafka
- provides higher throughput, *built-in partitioning, replication, and inherent fault-tolerance*
  
---
There are 2 *async* messagin patterns :
1. Message Queue
   - a creating app sends a msg to queue. When the consuming app is ready, it just connects to the queue and retrieves the msg, removing it from the queue. 
   - several consuming apps can exist, **each message is only consumed by one**.

2. Publish/Subscribe (pub/sub) 
   - allows producers to publish msg's which can be consumed by multiple consumer.
   - if consuming apps are interested, they just subscribe to a channel
   - used when a msg or event must trigger several actions
   - unlike the message queue, pub/sub *assures* that consuming apps rcv msg's in the *same order* as messaging system received them.
  
  ---
## RabbitMQ Architecture
- consists of 
  - producers
  - exchanges
  - queues
  - consumers
  
 ```                         
                             queues  
            msg              |---->
  producer -----> exchange --|----> consumers
                             |---->
                           or other 
                            exchanges
  ```
- *queue* is a sequential data structure:
    - producers add to the end 
    - consumers get data from the top
    - FIFO 
- *msg exchange* determines routing
  - 4 exchange types:
    - direct 
      - can directly target msg's to a particular queue
  ![direct exchange](https://miro.medium.com/max/1400/1*_Jzl2o13xBPn3CsdATBaxw.png "direct exchange")
    - fanout
      - route msg's to all available queues
  ![fanout exchange](https://miro.medium.com/max/1400/1*Hn3SaZuE1o3C1-IayaU9AQ.png "fanout exchange")
    - topic
    - header
---
## Kafka Architecture  
- consists of
  - producers
  - consumers
  - clusters
  - brokers
  - topics
  - partitions
```
producer --------> cluster -------> consumer
```
![kafka architecture](https://miro.medium.com/max/1376/1*TIKFG4HHYx4W6RbE1BWblA.png)

---
## Use cases
- Rabbit MQ
  - complex routing - route msg's among miltiple consuming apps, such as in a microservice architecture
  - legacy applications

![rabbit use cases](https://miro.medium.com/max/1400/1*Kyps08v9VSh5QwETNOVuHw.png)
- Kafka
  - high-troughput activity tracking 
  - stream processing
  - event sourcing
  - log aggregation
![kafka use cases](https://miro.medium.com/max/1400/1*001aX2FBDS4qz8nPLNiXAg.png) 


---
## References
 https://medium.com/@mbhanuka/kafka-vs-rabitmq-3ae75abe9c80

