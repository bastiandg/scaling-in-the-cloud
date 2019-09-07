# Scaling Talk

## General setup

- install [packer](https://www.packer.io/downloads.html)
- install [terraform](https://www.terraform.io/downloads.html)
- install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- install a benchmarking tool / load generator (the examples use [`wrk`](https://github.com/wg/wrk))
- create service account
- assign roles:
    - "Compute Admin" (roles/compute.admin) - for creating VM instances, disks, images and load balancers
    - "Service Account User" (roles/iam.serviceAccountUser) - for using the compute and k8s service accounts
    - "Cloud Build Editor" (roles/cloudbuild.builds.editor) - for starting cloud builds
    - "Storage Admin" (roles/storage.admin) - for creating a bucket the cloud build needs
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
wrk --duration 120 --connections 10 --timeout 5s --latency "http://$service_ip/"
```

After around 30 - 60 seconds the scaling will set in.

## Kubernetes

### deploy kubernetes cluster

```sh
cd k8s/
# Create a docker image of the service
gcloud builds submit ../service/ --project "$project_id" --config cloudbuild.yaml --substitutions "_SERVICE_NAME=$service_name" --async
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
wrk --duration 120 --connections 20 --timeout 5s --latency "http://$service_ip/"
watch kubectl get nodes # this has to be opened in another window
```

### Build image

```sh
gcloud builds submit ../service/ --project "$project_id" --config cloudbuild.yaml --substitutions "_SERVICE_NAME=$service_name" --async
```

https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/
