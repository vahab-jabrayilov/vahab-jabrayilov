---
title: "Will Serverless End the Dominance of Linux in the Cloud? HotOS’17"
summary: "A summar of the same paper from HotOS'17"
date: 2022-09-05
math: true
featured: false
authors: 
 - admin
tags: 
 - serverless
 - linux
 - hotos
 - hotos17
 - 2017
categories:
 - Paper Reviews 
---
## Review
It’s a very short read and one of the early works. The main topic of discussion is the shortcomings of the Linux kernel for the current serverless paradigm. They argue that native container abstraction is ill-suited to be run as a unit of execution for serverless. They show that bypassing the kernel with unikernels can yield at least a factor of 6 better latency and throughput.  While the unit of execution in the cloud shrinks, the complexity of the kernel is growing. It’s hard to introduce new abstractions to the kernel as it takes a lot of development investment and the kernel and its community have an inertia towards fast development. 

There are 3 potential approaches to accommodate the serverless in the cloud:
- Modify or extend the kernel
- Bypass the kernel
- Replace the kernel

Very little of the current complexity of the kernel is required for serverless. Two main requirements for the serverless are well isolation from the other tenants as well as host platform, and lambda actions must perform well. The first one removes the solely implementation on top of the native linux processes from the scene. The latter one has two main constituents, low latency and higher throughput. According to the authors, the target goal for the latency is to fetch and start any action under 100ms without any cached state.  To cover the financial objectives, achievable throughput should be at least 125.23 actions per second(One can see a back of the envelope calculation in the paper; simply they do calculations based on the pricing of AWS Lambda and EC2). 

![img1](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/fec8f177-e353-425b-a0fa-2e682f023448/Screenshot_from_2022-09-06_12-43-19.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220906%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220906T084434Z&X-Amz-Expires=86400&X-Amz-Signature=055a2800d2ccf91387a10acdde046d84103bda37b5ea19c5f73e70a99c729240&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screenshot%2520from%25202022-09-06%252012-43-19.png%22&x-id=GetObject)

Enhancing the Linux kernel and its container-related capabilities is the favored approach by the industry due to the large investment and dependency on the kernel itself. Moreover, containers are the most popular configuration and existing unit of execution in the current systems. To introduce the support for containers, the Linux kernel underwent major changes to include new abstractions like cgroups and namespaces. But the next significant changes can take longer, because the complexity affects implementation time. It is either hard to implement something in the kernel, and/or too hard to optimize the relevant code paths in the kernel, and/or too hard to secure the kernel. 

The second approach is to bypass the complexity of the kernel and add another layer from which actions(lambda’s) can be started. It can be either achieved on top of hypervisor or unikernel monitors. Bypassing the kernel is commonplace for data plane network services using hardware-level virtualization and software frameworks like DPDK.

Replacing the kernel with a new and custom designed for serverless type workloads is the way authors emphasize. They serve following alternative design considerations for the new kernel:
Non -preemptive scheduling
Limited set of I/O related calls
No IPC
No process synchronization

To support their arguments, they do a very simple experiment, running a simple “Hello” example in 3 ways. The baseline is running “echo “Hello”” as a native process, to experiment the containerization they run a similar binary inside the most minimal container via runc, statically linking the binary, without all the overhead of container runtime(Not using docker, networking, and etc.). To show the effect of kernel bypass, a unikernel(ukvm) running Solo5/ukvm is used. Results support the above mentioned arguments.

![img2](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/aa8d7914-6ff6-4229-85cc-ae94161c503a/Screenshot_from_2022-09-06_12-40-34.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220906%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220906T084345Z&X-Amz-Expires=86400&X-Amz-Signature=e1132f5068c939c24f4338ffa78dd3b5ce06206241eaf41c94ad398cc21169e9&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screenshot%2520from%25202022-09-06%252012-40-34.png%22&x-id=GetObject)


## References
 - [Will Serverless End the Dominance of Linux in the Cloud? ](https://dl.acm.org/doi/pdf/10.1145/3102980.3103008)
