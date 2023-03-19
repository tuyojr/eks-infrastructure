#

![Altschool Africa](https://github.com/tuyojr/cloudTasks/blob/main/logos/AltSchool.svg)

## REQUIREMENTS

1. A control node with git, terraform installed.
2. AWS account, AWS CLI installed and configured.

## SETTING UP THE JENKINS SERVER

In the `jenkins-server` folder above, you will find the terraform code to set up the Jenkins server on ubuntu 20.04. Run the following commands to set up the server.

```bash
terraform init
terraform apply --auto-approve
```

This will create the VPC (and all its other components), I'm using a pre-existing keypair with it. You can change the keypair name in the `jenkins-server.tf` file. There's also a script to install all the required packages on the server. You can find it in the `ubuntu-script.sh`. When the infrastructure is complete, the public IP address of the server will be displayed. You can use this to access the server. `http://<public-ip-address>:8080`.
SSH into the server and display the required password to unlock Jenkins. You can use this to login to the server.
Configure your github and aws credentials, create a pipeline, and you are good to go.


## SETTING UP THE EKS CLUSTER AND DEPLOYING THE APPLICATIONS

In the `jenkins-pipeline/aws` folder, there are configurations files to provision the eks cluster.
In the `jenkins-pipeline/k8s` folder, there are configuration files to deploy the applications on the cluster and create a DNS on route53.

## MONITORING THE APPLICATIONS WITH PROMETHEUS

There are configuration files to deploy prometheus and grafana in the `jenkins-pipeline/manifests-monitoring` folder. You can use these to monitor the applications. To access the prometheus dashboard, you can use the following command on your jenkins server.

```bash
kubectl port-forward svc/prometheus-server 9090:80 -n monitoring --address 0.0.0.0
```

To access the grafana dashboard, you can use the following command on your jenkins server.

```bash
kubectl port-forward svc/grafana 3000:80 -n monitoring --address 0.0.0.0
```