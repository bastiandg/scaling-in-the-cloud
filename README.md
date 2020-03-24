# Scaling Talk

- [slides](scaling-talk.pdf)
- [Image sources](images/README.md)

## General setup

- install [packer](https://www.packer.io/downloads.html)
- install [terraform](https://www.terraform.io/downloads.html)
- install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- install [gcloud](https://cloud.google.com/sdk/install)
- install a benchmarking tool / load generator (the examples use [`hey`](https://github.com/rakyll/hey))
- create service account
- assign roles:
    - "Compute Admin" (roles/compute.admin) - for creating VM instances, disks, images and load balancers
    - "Service Account User" (roles/iam.serviceAccountUser) - for using the compute and k8s service accounts
    - "Cloud Build Editor" (roles/cloudbuild.builds.editor) - for starting cloud builds
    - "Storage Admin" (roles/storage.admin) - for creating a bucket the cloud build needs
    - "Cloud Run Admin" (roles/run.admin) - for deploying to cloud run
    - "Kubernetes Engine Admin" (roles/container.admin) - for deploying kubernetes clusters
- Enable the APIs:
    - "Compute Engine Api" (compute.googleapis.com)
    - "Cloud Run API" (run.googleapis.com)
    - "Kubernetes Engine API" (container.googleapis.com)
    - "Cloud Build API" (cloudbuild.googleapis.com)
- create credentials file for the account
- customize and load the variables
    ```sh
    cp env.sh.example env.sh
    editor env.sh # change project_id and credentials location
    . env.sh
    ```

## VM example

### Setup

```sh
cd vm/
packer build image.json # creates a vm base image
terraform init          # initializes terraform
terraform plan          # shows resources terraform will create
terraform apply         # applies resources
sleep 300               # Wait for the Instances and the load balancer to be up
```

### Scaling test

```sh
export service_ip="$(terraform output vm_lb_ip_address)"
hey -q 20 -c 20 -n 2000 "http://$service_ip/"
```

After around 30 - 60 seconds the scaling will set in.

## Kubernetes

### build image

```sh
cd k8s/
# Create a docker image of the service
gcloud builds submit ../service/ --project "$project_id" --config cloudbuild.yaml --substitutions "_SERVICE_NAME=$service_name" --async
```

### deploy kubernetes cluster

```sh
cd k8s/
# Set up the terraform cluster
terraform init
terraform plan
terraform apply
```

### deploy hashy service

```sh
# Setup kubectl config for cluster
gcloud container clusters get-credentials hashy-cluster --zone "$zone" --project "$project_id"

kubectl get nodes # show kubernetes nodes
envsubst < deployment.yaml | kubectl apply -f - # deploy application
envsubst < service.yaml | kubectl apply -f - # create a service
envsubst < autoscaler.yaml | kubectl apply -f - # create an auto scaling object
```

### Scaling test

```sh
kubectl get services
export service_ip="$(kubectl get services "$service_name" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
hey -q 20 -c 20 -n 2000 "http://$service_ip/"
watch kubectl get nodes # this has to be opened in another window
```

## Cloud Run

### Build image

```sh
gcloud builds submit ../service/ --project "$project_id" --config cloudbuild.yaml --substitutions "_SERVICE_NAME=$service_name" --async
```

### Deployment

```sh
gcloud run deploy hashy --allow-unauthenticated --image="gcr.io/${project_id}/${service_name}-image" --platform managed --region europe-west1
```

### Scaling test

```sh
export RUN_URL="$(gcloud run services list --format='value(status.url)' --platform managed)"
bash hey.sh
```

## Links

- [draw.io for gcp](https://www.draw.io/?libs=gcp2)
- [The Lift-and-Shift Fallacy](https://www.contino.io/insights/the-lift-and-shift-fallacy-why-it-will-cost-you-time-money-and-people)
- [Velostrata](https://cloud.google.com/migrate/compute-engine/)
- [Packer](https://packer.io/)
- [managed instance groups](https://cloud.google.com/compute/docs/instance-groups/#managed_instance_groups)
- [horizontal pod auto scaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-custom-metrics)
- [Creating a service](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#creating-a-service)
- [Exposing a Service](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#exposing-the-service)
- [Example deployment](https://cloud.google.com/run/docs/quickstarts/prebuilt-deploy)
- [Pricing](https://cloud.google.com/run/pricing)
- [Knative](https://knative.dev/)
- [Cloud Run Introduction](https://www.youtube.com/watch?v=xVuuvZkYiNM)
- [marp example](https://raw.githubusercontent.com/yhatt/marp/master/example.md)
