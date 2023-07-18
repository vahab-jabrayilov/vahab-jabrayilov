---
title:  "Firecracker: Lightweight Virtualization for Serverless Applications"
summary: "A paper review for the same paper from NSDI'20"
date: 2022-07-21
math: true
featured: false
authors: 
 - admin
tags: 
 - serverless
 - firecracker
 - microvm
 - nsdi
 - nsdi20
 - 2020
categories:
  - Paper Reviews 
---

- [Summary](#summary)
- [Background](#background)
  - [Virtualization](#virtualization)
  - [Lambda](#lambda)
  - [Interesting points](#interesting-points)
- [References](#references)
## Summary

- Firecracker is a high-performance virtualization solution built to run Amazon’s serverless applications securely and with minimal resources. It now does so at immense scale.

## Background

### Virtualization
- Initially, a separate VM per Lambda customer, but existing VM solutions required significant resources, hence resulting in non-optimal utilization.
- 2 types of hypervisors
    - Type 1
        - directly integrated in the hardware
    - Type 2
        - run an operating system on top of the hardware, then run the hypervisor on top of that operating system
    
![https://www.micahlerner.com/assets/firecracker/Hypervisor.svg](https://www.micahlerner.com/assets/firecracker/Hypervisor.svg)
    
- Linux has a hypervisor built into the kernel - Kernel Virtual Machine, arguably a *Type 1* hypervisor.
    
[ols2007v1-pages-225-230.pdf](https://www.kernel.org/doc/ols/2007/ols2007v1-pages-225-230.pdf)
    
- **virtio** (linux provided interface) allows the user space kernel components to interact with the host OS. Rather than passing all interactions with a guest kernel directly to the host kernel, some functions (particularly, device interactions) go from a guest kernel to a virtual machine monitor (a.k.a VMM) (a popular example: QEMU)
    
[bellard.pdf](https://www.usenix.org/legacy/publications/library/proceedings/usenix05/tech/freenix/full_papers/bellard/bellard.pdf)
    
- Cons(-) of QEMU:
    - significant amount of code ⇒ more code, more potential attack surface
    - redundant functionality, that Lambda would never use: such as support for USB drivers
- So, **crosvm** is chosen (a VMM open-sourced by Google and developed for ChromeOS)
[Paravirtualized Devices in crosvm - a Performance Panacea for Modern VMs](https://prilik.com/blog/post/crosvm-paravirt/)
    

### Lambda

- When a lambda is invoked, the ensuing HTTP request hits an AWS Load Balancer.

![https://www.micahlerner.com/assets/firecracker/arch.png](https://www.micahlerner.com/assets/firecracker/arch.png)

- 4 main components:
    - Workers
        - the component running lambda’s code
        - each runs many MicroVMs in “slots” and other services schedule code to be run in the MicoVMs when a lambda is invoked
    - Frontend
        - entrance into the lambda system
        - receives invoke requests and communicate with Worker Manager to determine where to run the lambda. then directly communicates with the Workers
    - Worker Manager
        - ensures that the same lambda is routed to the same set of Workers
        - keep tracks of where a lambda has been scheduled previously
    - Placement service
        - makes scheduling decisions to assign a lambda invocation to a worker
- Lambda Worker Architecture
    - Firecracker VM
    - Shim process
        - process inside of the VM that communicates with an external side car called the Micro Manager
    - Micro Manager
        - a sidecar communicating over TCP with a Shim process
        - reports metadata received back to the Placement service
        - can be called from the Frontend to invoke a specific function
        - on the function completion, receives the response from the shim process passing back to the client as needed

![https://www.micahlerner.com/assets/firecracker/lambdaworker.png](https://www.micahlerner.com/assets/firecracker/lambdaworker.png)

### Interesting points

- Only IO performance was inferior, and they argue that causes are no flushing to disk and an implementation of block IOs which performs IO serially; async IO support with io_uring can resolve it, there is an issue about it in github.

[[Perf] Implement async IO for the block device using io_uring · Issue #1600 · firecracker-microvm/firecracker](https://github.com/firecracker-microvm/firecracker/issues/1600)

[Lord of the io_uring](https://unixism.net/loti/what_is_io_uring.html)

## References

- blog post: [Firecracker: Lightweight Virtualization for Serverless Applications](https://www.micahlerner.com/2021/06/17/firecracker-lightweight-virtualization-for-serverless-applications.html)
- paper: (https://www.usenix.org/conference/nsdi20/presentation/agache)