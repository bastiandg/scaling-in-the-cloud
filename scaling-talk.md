Climbing up the scaling ladder
==============================


<!-- $size: 16:9 -->


---

# Scaling in the cloud

- 3 Scaling scenarios
- demos at [scale.8c.at](https://github.com/bastiandg/scaling-in-the-cloud/) ⚖️8️🐱
- cloud is not about cost, it is about scaling

<!--- side effect: acceleration-->
<!--- cost reduction? probably not [>TODO point still valid? If yes elaborate.<]-->

---

![bg 30%](images/scaling-ladder.png) <!--TODO Colors-->

---

# Lift and shift

<!--![bg width:600px left](images/house-cropped.jpg)-->
![bg height:100% left](images/house-cropped.jpg)
- Migrate legacy VMs/Software with (almost) no modification
- Doesn't scale very well (bigger VMs, faster disks)
- Your mess for less
- Conclusion: don't do it

<!--https://pixabay.com/photos/house-uprooted-installation-1614922/-->

<!--- Velostrata-->

<!-- # immutable infrastructure-->

<!--- Computing infrastructure doesn't change at runtime-->
<!--- Operating System images are prebuilt-->
<!--- Separation of storage and computing-->

---

# Autoscaled Host Groups

![bg height:100% right](images/terracotta-army-cropped.jpg)
- Lift and Shift +
- Paradigm shift: VMs are containers
- Make infrastructure immutable
- Persist data outside VM
<!--- vm scaling mechanisms of the cloud (gcp: managed instance group)-->

---

# Ingredients Autoscaled Host Groups

- Managed instance group
    - VM Autoscaler
- Packer
    - VM Image
- Terraform
    - VM Template
    - Managed instance group
    - Loadbalancer

<!--- Scaling unit: VM-->
<!--- Packer-->

---

# Managed instance group in GCP

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/managed-instance-group.png)

---

# Demo Autoscaled Host Groups

![bg width:300px right](images/demo.png)

---

# Container Orchestration

<!--https://pixabay.com/photos/search/harbor%20container/-->
<!--https://pixabay.com/photos/hamburg-port-of-hamburg-3021820/-->
<!--https://pixabay.com/photos/port-ships-cranes-load-containers-675539/-->
<!--https://pixabay.com/photos/port-ships-cranes-load-containers-614543/-->
![bg height:95% left](images/kubernetes-logo.png)
- Paradigm shift: There are no VMs <!--- TODO -->
- Pool of resources
- services containerized

---

# Ingredients Container Orchestration

- Terraform
    - Kubernetes Cluster
    - Node Autoscaler
- Docker
    - Container image
- Kubernetes
    - Deployment
    - Horizontal Pod Autoscaler
    - Service

---

# Kubernetes cluster

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px center](images/kubernetes-deployment1.png)

---

# Kubernetes deployment

<style scoped>
section {
    text-align: center;
}
</style>


![height:600px](images/kubernetes-deployment2.png)

---

# Kubernetes pod autoscaler

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/kubernetes-deployment3.png)

---

# Kubernetes service

<style scoped>
section {
    text-align: center;
}
</style>

![height:600px](images/kubernetes-deployment4.png)

---

# Demo kubernetes

![bg width:300px right](images/demo.png)

---

# serverless

<!--https://www.pexels.com/search/balloon/-->

- Paradigm shift: There is no infrastructure <!--- TODO -->
- No infrastructure management
- Pay per use
- stateless

---

# Ingredients serverless

- Docker
    - Container Image
- Cloud Run
    - Deployment

---

# Demo serverless

![bg width:300px right](images/demo.png)

---

# Takeaways

- Don't do lift and shift
- separate storage from computing

<!--- TODO Don't use Docker as a light VM-->
