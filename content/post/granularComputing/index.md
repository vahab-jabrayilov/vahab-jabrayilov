---
title:  Granular Computing
summary: A summary for the same paper from HotOS'19
date: 2023-07-18
math: true
featured: false
authors: 
 - admin
tags: 
 - serverless
 - granular computing
 - hotos
 - hotos19
 - 2019
categories:
 - Paper Reviews
---

## Review

This paper is by the group of John Ousterhout and introduces the concept of so called “Granular computing”. They define “Granular computing” as the collection of very short-lived (10-100 usecs) tasks. The other main properties are large scale(1k-1M cooperating tasks) and short bursts(1-10 msecs of activity).  Authors discuss the challenges coming with the new concept and present a few initial ideas about the required infrastructure to support it. 

In granular computing, applications are composed of a very large number of small tasks running in microsecond scale both in parallel and sequentially, spread across thousands of machines. In addition, they are bursty, harnessing thousands of machines for just a few intense milliseconds of computation. In today’s software systems, overheads are too high to support small tasks efficiently or to scale up and down rapidly. Precisely, granular computing requires software infrastructure that operates at microsecond scale, but today’s systems are designed for millisecond scale. 

Authors defend an extreme approach over an incremental one, which will stimulate innovative design thinking. They introduce real-time data-intensive processing and micro-lambdas as two classes of applications which can be possible by granular computing. It is argued that granular computing will enable real-time data-intensive processing to have smaller latency overhead for invoking requests and higher degree of concurrency. Regarding micro lambdas, it will support tasks three orders of magnitude smaller and will allow lambdas to work together by communicating. 

Low latency is one of the major challenges to overcome. Granular computing will require extremely low latency in task initiation and network communication. It shouldn’t take more than 1 usec to invoke a single task and 100 usecs to initiate tasks in the burst. Microsecond-scale network communication is essential both for fast burst startup and communication among short-lived tasks. Particularly, tail latency matters, since it is difficult to optimize and eliminate infrequent sources of overhead. 

Extreme bursts require to start very quickly by communicating with many servers in parallel and allocate resources on them. The second challenge here is resource utilization. In order to use resources efficiently, non-bursty background tasks must be run during the lulls between bursts, and the system must be able to preempt them very quickly at the start of the next burst. 

Below mentioned overheads show why it is not possible to support granular computing with existing systems:
- Creating a thread on Linux takes 10 usecs
- A network RTT between two servers in the same datacenter can take 500 usecs or more when the network is loaded
- Spinning up a Linux container takes hundreds of milliseconds
- Initiating a job that spans a few hundred nodes with Spark, Kubernetes or AWS Lambda can take one second or more.
  
Authors mention two major causes of these overheads. First, existing software infrastructure was designed to operate at a millisecond scale, not microsecond. The assumption of disk-based storage permeates much of the design of today’s software. A second problem is high layering. Each layer crossing adds overhead. Granular computing will require a significant re-architecture of the software stack to eliminate layers or bypass them.

Service concept is introduced as a granular computing unit, which can be either stateless or stateful. This separation based on state helps the underlying infrastructure to leverage its resources efficiently. They also propose two kinds of addressing that will raise the level of abstractions for network communication: service-based addressing and resource-based addressing. In service-based addressing, communication is directed at a particular service, and the infrastructure can load-balance the requests across the service’s instances. It is most appropriate for stateless services. In resource-based addressing, communication is directed to a particular resource, such as a piece of data with a particular data in a key-value store. It makes sense for stateful services. Authors also emphasize the need for efficient group communication with the higher-level addressing mechanisms they propose. Handling bursts are more complex and require sophisticated mechanisms to preempt resources from long running tasks, to isolate short-lived tasks efficiently. Moreover, keeping warm pools to reduce service latency would be unmanageable for large numbers of small tasks since they consume idle resources. Regarding persistence, they favor use of emerging nonvolatile memories or enforcing persistence only occasionally. But the latter isn’t trivial and may require assistance from applications. 


## References
 - [Granular Computing](https://dl.acm.org/doi/pdf/10.1145/3317550.3321447)
