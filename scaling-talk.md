# Scaling talk draft

- not just a talk, also demo at [bastiandg/scaling-in-the-cloud](https://github.com/bastiandg/scaling-in-the-cloud/)

## Scaling in the cloud

- cloud is not about cost, it is about scaling
- side effect: acceleration
- cost reduction? probably not <!--TODO point still valid? If yes elaborate.-->
- immutable infrastructure required
- Everything talks via http

Scaling Ladder Illustration <!--TODO-->
[draw.io for gcp](https://www.draw.io/?libs=gcp2)

## immutable infrastructure

- Computing infrastructure doesn't change at runtime
- Operating System images are prebuilt
- Separation of storage and computing

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
- Paradigm shift: Every infrastructure component is immutable
- Make infrastructure immutable
- Persist data outside VM
- Packer
- vm scaling mechanisms of the cloud (gcp: managed instance group)
- Scaling unit: VM

[Packer](https://packer.io/)
[managed instance group](https://cloud.google.com/compute/docs/instance-groups/#managed_instance_groups)

## k8s

- Paradigm shift: There are no VMs <!--- TODO -->
- Pool of resources
- services containerized
- Scaling unit: pod

[horizontal pod auto scaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-custom-metrics)
[Creating a service](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#creating-a-service)
[Exposing a Service](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#exposing-the-service)

### Demo

- Containerize Service
- Set up node auto scaling
- Set Pod autoscaling
- Deploy

## serverless

- Paradigm shift: There is no infrastructure <!--- TODO -->
- No infrastructure management
- Pay per use
- stateless
- cloudfunctions
- Knative
- cloud run

[Example deployment](https://cloud.google.com/run/docs/quickstarts/prebuilt-deploy)
[Pricing](https://cloud.google.com/run/pricing)
[Knative](https://knative.dev/)
[Cloud Run Introduction](https://www.youtube.com/watch?v=xVuuvZkYiNM)

### Demo

- Containerize Service
- Deploy

## Takeaways

- Don't do lift and shift
- separate storage from computing
- Don't use Docker as a light VM

## Links

- [marp example](https://raw.githubusercontent.com/yhatt/marp/master/example.md)
