Scaling talk draft
==================

<!-- $size: 16:9 -->

- not just a talk, also demo at [bastiandg/scaling-in-the-cloud](https://github.com/bastiandg/scaling-in-the-cloud/)

---

# Scaling in the cloud

- cloud is not about cost, it is about scaling
- side effect: acceleration
- immutable infrastructure required
- Everything talks via http

<!--- cost reduction? probably not [>TODO point still valid? If yes elaborate.<]-->

---

![bg 30%](images/scaling-ladder.png)
Scaling Ladder Illustration <!--TODO Colors-->

---

# Lift and shift

- Migrate legacy VMs/Software with (almost) no modification
- Doesn't scale very well (bigger VMs, faster disks)
- Your mess for less
- Conclusion: don't do it

<!--- Velostrata-->

---

# Autoscaled Host Groups

- Lift and Shift +
- Paradigm shift: VMs are containers
- Make infrastructure immutable
- Persist data outside VM
- vm scaling mechanisms of the cloud (gcp: managed instance group)

<!--- Scaling unit: VM-->
<!--- Packer-->

---

# immutable infrastructure

- Computing infrastructure doesn't change at runtime
- Operating System images are prebuilt
- Separation of storage and computing

---

# k8s

- Paradigm shift: There are no VMs <!--- TODO -->
- Pool of resources
- services containerized
- Scaling unit: pod

---

# Demo kubernetes

- Containerize Service
- Set up node auto scaling
- Set Pod autoscaling
- Deploy

---

# serverless

- Paradigm shift: There is no infrastructure <!--- TODO -->
- No infrastructure management
- Pay per use
- stateless
- cloudfunctions
- Knative
- cloud run

---

# Demo serverless

- Containerize Service
- Deploy

---

# Takeaways

- Don't do lift and shift
- separate storage from computing

<!--- TODO Don't use Docker as a light VM-->
