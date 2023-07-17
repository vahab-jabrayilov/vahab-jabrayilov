---
title: Metastable Failures in Distributed Systems
summary: A summary of the same paper published in HotOS'21
date: 2022-07-18
math: true
featured: false
authors: 
 - admin
tags: 
 - failures
 - metastability
 - hotos
 - hotos21
 - 2021
categories: 
 - Paper Reviews 
---
## Introduction
- Interestingly, most features improving the efficiency or reliability are the main cause of *metastable failures*.
- Trigger causes the open system (with an unctrolled source of load) to enter a **bad state** persisting even after the removal of the trigger.
- Failures that are **resolved when the trigger is removed** are not metastable.
- Recovery requires *a strong corrective push*, e.g. rebooting or dramatically reducing the load.
- Lifecycle of a metastable failure:
  ```
                 load rises                     trigger
    stable state ------------> vulnerable state --------> metastable state
                                (still healthy)
  ```
  - the vulnerable state is not an overloaded state; system can run for a long time here; but can get stuck in *metastable state* w/o any increase in the load.
  - interestingly most production systems prefers the vulnerable state since it has higher efficiency than the stable state.
- *Feedback loop* sustains the failure until a corrective action is applied.
## Case studies
- Request Retries
  - Results in work amplification
  - Consider a web application with db. Initially, system operates normally while load is just below a certain threshold. After a temporary network outage occurs and restores, retries are sent and this surge overloads the db. Overloaded db timeouts the upcoming queries and system will remain in metastable state untill the load is significantly reduced or timeout(retry) policy of db query changed.
- Look-aside Cache
  - If cache is lost in the vulnerable state, db will be pushed to overloaded state. Cache will remain empty, system is trapped in metastable failure state; 
    - low cache hit -> slow db response -> prevents filling the cache
- Slow Error Handling
  - Error handling has its cost and it can be a significant cost
  - Trigger causes the system to run out of the resources used by error handling code, and error handling will make the shortage more severe. 
  - **??? -- to think** Is the following considered? --> An error occurs(like wrong input), error handling code makes the resources to run out, normal operations are deprived of resources resulting in additional errors(exceptions), which draw the system to a metastable state.
- Link Imbalance
  - a very interesting and solid example; both requiring network and application layer collaboration to fix
  - a complex and well designed hashing algorithm routes the requests; but the cache miss of a single shard in the application level increases the requests to the db. There is a connection pool with MRU policy, each spike of misses reaarranges the connection pool so that highest latency links are at the top and they will be used; resulting in further congestion. 

## Approaches to Handling Metastability
- Trigger vs Root Cause: Sustaining feedback loop is the root cause rather than the trigger itself. Different triggers can result in the same failure state; hence solution is to address the sustaining effect.
- Change of Policy during Overload: e.g., make some failing requests to succeed.
- Prioritization: e.g., give priority to retries requests rather than new ones.
- Stress tests **TODO: read the Kraken paper** 
- Organizational incentives
- Fast Error Paths
- Outlier Hygiene: same root cause can manfiest earlier as latency outlier or a cluster of errrors.
- Autoscaling

## Research Directions
- 2 main goals:
  - designing systems that avoid metastable failures while operating efficiently
  - developing mechanisms to recover from metastable failures as quickly as possible in cases that cannot be avoided
- Try to weaken the strongest feedback loops, discover about characteristic metric, using them generate warning signs;
- Learning the hidden capacity of the underlying system can help to take preventive actions.

## References
- https://sigops.org/s/conferences/hotos/2021/papers/hotos21-s11-bronson.pdf