# Scaling talk draft

## Scaling in the cloud

- cloud is not about cost, it is about scaling
- side effect: acceleration
<!--TODO point still valid?-->
- cost reduction? probably not
- immutable infrastructure required

## immutable infrastructure

- Computing infrastructure doesn't change at runtime
- Operating System images are prebuilt


## Lift and shift

- Migrate legacy VMs/Software with (almost) no modification
- Doesn't scale very well (bigger VMs, faster disks)
- Your mess for less
- Velostrata
- Conclusion: don't do it

[The Lift-and-Shift Fallacy](https://www.contino.io/insights/the-lift-and-shift-fallacy-why-it-will-cost-you-time-money-and-people)
[Velostrata](https://cloud.google.com/migrate/compute-engine/)
[Old tree](https://pixabay.com/photos/tree-nature-wood-landscape-plant-3249744/)
[Uprooted House](https://pixabay.com/photos/house-uprooted-installation-1614922/)

## VM based scaling

- Lift and Shift +
- Make infrastructure immutable
- Persist data outside VM
- Packer
- vm scaling mechanisms of the cloud (gcp: managed instance group)
- Scaling unit: VM

[Packer](https://packer.io/)
[managed instance group](https://cloud.google.com/compute/docs/instance-groups/#managed_instance_groups)

## k8s

- Pool of resources
- services containerized
- Scaling unit: pod

[horizontal pod auto scaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-custom-metrics)

### Demo

- Containerize Service
- Set up node auto scaling
- Set Pod autoscaling
- Deploy

## serverless

- cloudfunctions
- Knative
- cloud run

### Demo

- Containerize Service
- Deploy

## Links

- [marp example](https://raw.githubusercontent.com/yhatt/marp/master/example.md)
