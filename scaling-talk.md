Climbing up the Scaling Ladder
==============================


<!-- $size: 16:9 -->

---

# Scaling in the Cloud

- Disclaimer: Focus on standard applications (not Machine Learning or Storage)
- 3 Scaling scenarios (with examples)
- Demos at [scale.8c.at](https://github.com/bastiandg/scaling-in-the-cloud/) ⚖️8️🐱
- Cloud is not about cost, it is about scaling
- Reduced cost is a side effect

<!--- side effect: acceleration-->

---

![bg 30%](images/scaling-ladder.png)

---

# Lift and Shift

<!--![bg width:600px left](images/house-cropped.jpg)-->
![bg height:100% left](images/house-cropped.jpg)

- Migrate legacy VMs / Software with (almost) no modification
- Doesn't scale very well (bigger VMs, faster disks)
- Your mess for less
- Conclusion: don't do it (in most cases)

<!--https://pixabay.com/photos/house-uprooted-installation-1614922/-->

<!--- Velostrata-->

<!-- # immutable infrastructure-->

<!--- Computing infrastructure doesn't change at runtime-->
<!--- Operating System images are prebuilt-->
<!--- Separation of storage and computing-->

---

# Autoscaled Host Groups

![bg height:100% right](images/terracotta-army-cropped.jpg)
- Lift and Shift done right
- Paradigm shift: VMs are containers
- Make infrastructure immutable
- Persist data outside VM
<!--- vm scaling mechanisms of the cloud (gcp: managed instance group)-->

---

# Example Autoscaled Host Groups

<style scoped>
table, td, th, tr {
    border: none;
}
</style>

| | |
|:--------:|-------------|
| ![width:110px right](images/packer-logo.svg) | - VM Image |
| ![width:130px right](images/gce-logo.svg) | - Managed Instance Group -> VM Autoscaler |
| ![width:130px right](images/terraform-logo.svg) | - VM Template <br> - Managed instance group <br> - Loadbalancer|

<!--- Scaling unit: VM-->
<!--- Packer-->

---


# Managed Instance Group in GCP

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/managed-instance-group.png)

---

# Example Application

- Hashy

```
bcrypt( data=time.now(), cost=12 )
```

---

# Demo Managed Instance Group Part 1

![bg width:300px right](images/demo.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/mig-autoscaler-target.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/mig-autoscaler-cpu.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/mig-autoscaler-load.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/mig-autoscaler-scale.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/mig-autoscaler-scale2.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/mig-autoscaler-scale3.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/mig-autoscaler-final.png)

---

# Demo Managed Instance Group Part 2

![bg width:300px right](images/demo.png)

---

# Container Orchestration

<!--https://pixabay.com/photos/search/harbor%20container/-->
<!--https://pixabay.com/photos/hamburg-port-of-hamburg-3021820/-->
<!--https://pixabay.com/photos/port-ships-cranes-load-containers-675539/-->
<!--https://pixabay.com/photos/port-ships-cranes-load-containers-614543/-->
![bg height:100% left](images/port-cropped.jpg)
- Paradigm shift: There are no VMs <!--- TODO -->
- Pool of resources
- Services containerized

---

# Example Container Orchestration

<style scoped>
table, td, th, tr {
    border: none;
}
</style>

| | |
|:--------:|-------------|
| ![width:130px right](images/terraform-logo.svg) | - Kubernetes Cluster <br> - Node Autoscaler|
| ![width:130px right](images/docker-logo.png) | - Container Image |
| ![width:130px right](images/kubernetes-logo.png) | - Deployment <br> - Horizontal Pod Autoscaler <br> - Service|

---

# Kubernetes cluster

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/kubernetes-deployment1.png)

---

# Kubernetes Deployment

<style scoped>
section {
    text-align: center;
}
</style>


![height:600px](images/kubernetes-deployment2.png)

---

# Kubernetes Pod Autoscaler

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/kubernetes-deployment3.png)

---

# Kubernetes Service

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/kubernetes-deployment4.png)

---

# Demo Kubernetes Part 1

![bg width:300px right](images/demo.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/k8s-scaling-target-hpa.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/k8s-scaling-cpu.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/k8s-scaling-scale.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/k8s-scaling-scale2.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/k8s-scaling-node-scaler.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/k8s-scaling-node-scaleup.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/k8s-scaling-final.png)

---

# Demo Kubernetes Part 2

![bg width:300px right](images/demo.png)

---

# Serverless

![bg height:100% left](images/balloons-cropped.jpg)

- Paradigm shift: There is no infrastructure <!--- TODO -->
- No infrastructure management
- Pay per use
- Stateless

---

<!--border-bottom: 0px solid black;-->
# Example Serverless
<style scoped>
table, td, th, tr {
    border: none;
}
</style>

| | |
|-|-|
| ![width:100px right](images/docker-logo.png) | Container Image |
| ![width:100px right](images/cloud-run-logo.svg) | Deployment |

---

# Demo Serverless

![bg width:300px right](images/demo.png)

---

# Takeaways

![bg height:100% left](images/takeaways-cropped.jpg)

- Don't do lift and shift
- Cloud providers make scaling easy

<!--- Separate storage from computing-->
<!--- TODO Don't use Docker as a light VM-->
