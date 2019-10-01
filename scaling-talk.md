Climbing up the Scaling Ladder
==============================

![bg height:100% left](images/ladder-cropped.jpg)
<!--Alternative background https://www.flickr.com/photos/127932966@N07/15178278179/-->

<!-- $size: 16:9 -->

---

# Problem Statement

<style scoped>
section {
  font-size: 60px;
}
</style>

With inappropriate scaling you are losing customers 🏃 and money 💸.

<!--- side effect: acceleration-->

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/Context1.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/Context2.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/Context3.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/Context4.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/Context5.png)

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

Three Step process:
1. Persist data outside VM
2. Automate VM setup
3. Create VM image

<!--- Make infrastructure immutable-->
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
| ![width:110px right](images/gce-logo.svg) | - Managed Instance Group -> VM Autoscaler |
| ![width:110px right](images/terraform-logo.svg) | - VM Template <br> - Managed instance group <br> - Loadbalancer|

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
bcrypt( time.now() )
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

<style scoped>
section {
    padding: 40px;
}
</style>

<!--https://pixabay.com/photos/search/harbor%20container/-->
<!--https://pixabay.com/photos/hamburg-port-of-hamburg-3021820/-->
<!--https://pixabay.com/photos/port-ships-cranes-load-containers-675539/-->
<!--https://pixabay.com/photos/port-ships-cranes-load-containers-614543/-->
![bg height:100% left](images/port-cropped.jpg)
- Paradigm shift: There are no VMs <!--- TODO -->
- Pool of resources
- Services containerized
    -> strip out OS
    -> runtime image instead VM image

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

# Kubernetes Cluster

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/kubernetes-deployment-start.png)

---

# Kubernetes Deployment

<style scoped>
section {
    text-align: center;
}
</style>


![height:600px](images/kubernetes-deployment-deployment.png)

---

# Kubernetes Pod Autoscaler

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/kubernetes-deployment-hpa.png)

---

# Kubernetes Service

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/kubernetes-deployment-final.png)

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

![height:600px](images/k8s-scaling-node-scale1.png)

---

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/k8s-scaling-node-scale2.png)

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

- Scalability is a fundamental requirement
- Cloud providers make scaling easy
- Don't do lift and shift

<!--- Separate storage from computing-->
<!--- TODO Don't use Docker as a light VM-->
