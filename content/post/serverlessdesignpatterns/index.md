---
title:Go Serverless: Securing Cloud via Serverless Design Patterns 
summary: A summary of the same paper published in HotCloud'18
date: 2022-09-06
math: true
featured: false
authors: 
 - admin
tags: 
 - serverless
 - design patterns
 - hotcloud
 - hotcloud18
 - 2018
categories: 
 - Paper Reviews 
---

## Review
Authors have a security background and paper aims at utilizing serverless design patterns in security applications. They solely focus on AWS Lambda, and assume that all the responsibility to secure lambda execution lies on the cloud provider. However, customers are also responsible to secure their communication. They briefly describe six design patterns and how one can use them to develop a security oriented application.

**Periodic Invocation Pattern** represents the kind of models that invoke lambda functions periodically by using schedulers. Each function carries out a simple task and reports the execution results to notification channels.

![img1](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/02f5a2e9-9533-445d-829a-c1a7d700859a/Screenshot_from_2022-09-06_14-27-53.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220906%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220906T112230Z&X-Amz-Expires=86400&X-Amz-Signature=044ec7568fb7a8a9f2f283d272d2dd4acd85998bc0e780e707f9a237cbe85cb0&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screenshot%2520from%25202022-09-06%252014-27-53.png%22&x-id=GetObject)

**Event-Driven Pattern** is where a set of lambda functions subscribe to events from cloud resources. These events trigger the execution of the subscribed lambda function passing the necessary context. It minimizes the cost by invoking lambda functions only when an event occurs and functions scale automatically based on the number of events, providing a scalable design.

![img2](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/fabec05c-daa5-4473-9127-5138927928aa/Screenshot_from_2022-09-06_14-28-20.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220906%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220906T112316Z&X-Amz-Expires=86400&X-Amz-Signature=e27f03ead60903ecf5afd8b54a269458f073cdc48ffb2f97bd802e34c0fc6c27&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screenshot%2520from%25202022-09-06%252014-28-20.png%22&x-id=GetObject)

**Data Transformation Pattern.** The ETL(extract-transform-load) data processing pipelines usually requires three steps: 1) extract data from a data source, 2) transform data by using frameworks such as Apache Spark or Flink, 3) load the transformed data into a database. Using lambda architecture, data processing tasks can be implemented as lambda functions.

![img3](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/0f78fc8d-e13c-4097-8bf1-77332e538605/Screenshot_from_2022-09-06_14-28-04.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220906%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220906T112334Z&X-Amz-Expires=86400&X-Amz-Signature=fbbc6314227bd623be35efd53ca4733f7a071e6479e3b26382f501dfa013622f&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screenshot%2520from%25202022-09-06%252014-28-04.png%22&x-id=GetObject)

**Data Streaming Pattern.** A lambda function sits in the path of the data stream and functions either as an aggregator or data partitioner. For example, a lambda can separate an incoming data stream into multiple streams(partition) or merge several incoming streams into one large data stream(aggregation). 

![img4](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/e4d287b2-b415-475b-b317-3ec3d679d784/Screenshot_from_2022-09-06_14-28-27.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220906%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220906T112424Z&X-Amz-Expires=86400&X-Amz-Signature=55bdc34986556eb7277dc48d88ae9a232c4ceeb24e560ab8dbf273987d00ad8b&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screenshot%2520from%25202022-09-06%252014-28-27.png%22&x-id=GetObject)

**State Machine Pattern** enables building a complex, stateful procedure by coordinating a collection of discrete Lambda functions using a tool such as AWS Step Functions. It shouldn’t scale the entire pattern as tasks defined for each state can be scaled up/down individually, Furthermore, the state machine offers a try/catch mechanism so that different or the same functions can be invoked depending on the failure reason. 

![img5](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/401e5618-bacf-485a-96fc-abaaf51434ae/Screenshot_from_2022-09-06_14-28-49.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220906%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220906T112600Z&X-Amz-Expires=86400&X-Amz-Signature=1d396cf33d4e529556f352fbb586328b98f7e8a7450ccae47770030866b85881&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screenshot%2520from%25202022-09-06%252014-28-49.png%22&x-id=GetObject)

**Bundled Pattern** combines two or more of the previously described patterns together by easily passing events sequentially between them. It resembles UNIX pipelines, where each function is small, precise and does one thing, but true power comes from chaining these together. 

![img6](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/fc8aa752-ef51-453f-a570-3b4485f4b24c/Screenshot_from_2022-09-06_14-28-33.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220906%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220906T112614Z&X-Amz-Expires=86400&X-Amz-Signature=e27314a11b27d0a8f1eda160733388842ce62fece1595ef21542426424c095b0&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screenshot%2520from%25202022-09-06%252014-28-33.png%22&x-id=GetObject)

Authors show the time to start a lambda function(50-100ms) as a primary disadvantage. But lower prices for short running functions and better scalability are advantages. 

In later sections of the paper they describe a threat intelligence platform built upon the above mentioned design patterns, which is not interesting for our purpose. 

Authors also discuss some restrictions of current lambda design and offer possible solutions. Time bound execution is highlighted as one of the resource constraints and it can be avoided by splitting the original task across the multiple executions, but it is not possible for all workloads. They describe a proper solution as to either increase the execution time or to automatically pass state between executions so that the task can continue in another execution with the previous state. Lambda also suffers from lack of computing power. They argue that it would be better to have CPU limits configurable and support for GPUs in AWS Lambda. Moreover, lack of event tracing is emphasized by the authors. 

## References
- [Go Serverless: Securing Cloud via Serverless Design Patterns](https://www.usenix.org/conference/hotcloud18/presentation/hong)