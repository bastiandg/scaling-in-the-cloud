# Scaling Talk

## General setup

- install [packer](https://www.packer.io/downloads.html)
- install [terraform](https://www.terraform.io/downloads.html)
- install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- install a benchmarking tool / load generator (the examples use [`wrk`](https://github.com/wg/wrk))
- create service account
- set "Compute Admin" (roles/compute.admin) and "Service Account User" (roles/iam.serviceAccountUser) on the service account
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
cd vm
packer build image.json # creates a vm base image
terraform init          # initializes terraform
terraform plan          # shows resources terraform will create
terraform apply         # applies resources
sleep 300               # Wait for the Instances and the load balancer to be up
```

### Scaling test

`terraform apply` will output the IP address of the VM loadbalancer as `vm_lb_ip_address`. That IP address has to be used to put load on the VM Group.

```sh
wrk -d 120 -c 20 --latency "http://123.45.67.89/"
```

After around 30 - 60 seconds the scaling will set in.

## Kubernetes

### Build image

```sh
gcloud builds submit ../service/ --project "$project_id" --config cloudbuild.yaml --substitutions "_SERVICE_NAME=$service_name" --async
```

https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/
