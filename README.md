#

![Altschool Africa](https://github.com/tuyojr/cloudTasks/blob/main/logos/AltSchool.svg)

## REQUIREMENTS

1. A control node with git, terraform installed.
2. AWS account, AWS CLI installed and configured.
3. Terraform Installed on your local system.

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
kubectl port-forward svc/prometheus-server 8081:9090 -n monitoring --address 0.0.0.0
```

To access the grafana dashboard, you can use the following command on your jenkins server.

```bash
kubectl port-forward svc/grafana 8082:80 -n monitoring --address 0.0.0.0
```

## OUTPUT OF CREATED EKS INFRASTRUCTURE WITH TERRAFORM

![eks_output](https://github.com/tuyojr/eks-infrastructure/blob/main/images/eks_output.png)
![eks_vpc](https://github.com/tuyojr/eks-infrastructure/blob/main/images/eks_vpc.png)
![eks](https://github.com/tuyojr/eks-infrastructure/blob/main/images/eks.png)
![eks_overview](https://github.com/tuyojr/eks-infrastructure/blob/main/images/eks_overview.png)
![eks_network](https://github.com/tuyojr/eks-infrastructure/blob/main/images/eks_network.png)

## RUNNING SERVERS

![running_instances](https://github.com/tuyojr/eks-infrastructure/blob/main/images/running_instances.png)

## INSIDE THE CLUSTER

![nodes](https://github.com/tuyojr/eks-infrastructure/blob/main/images/nodes.png)
![nodes_and_nodegroups](https://github.com/tuyojr/eks-infrastructure/blob/main/images/nodes_and_nodegroups.png)
![pods_I](https://github.com/tuyojr/eks-infrastructure/blob/main/images/pods_I.png)
![pods_II](https://github.com/tuyojr/eks-infrastructure/blob/main/images/pods_II.png)
![notes_app_apply](https://github.com/tuyojr/eks-infrastructure/blob/main/images/notes_app_apply.png)
![sock_shop_apply](https://github.com/tuyojr/eks-infrastructure/blob/main/images/sock_shop_apply.png)
![monitoring_apply](https://github.com/tuyojr/eks-infrastructure/blob/main/images/monitoring_apply.png)
![weave_works_addon](https://github.com/tuyojr/eks-infrastructure/blob/main/images/weave_works_addon.png)
![deployments_I](https://github.com/tuyojr/eks-infrastructure/blob/main/images/deployments_I.png)
![deployments_II](https://github.com/tuyojr/eks-infrastructure/blob/main/images/deployments_II.png)
![deplyments_III](https://github.com/tuyojr/eks-infrastructure/blob/main/images/deployments_III.png)
![deployments_IV](https://github.com/tuyojr/eks-infrastructure/blob/main/images/deployments_IV.png)
![deployments_V](https://github.com/tuyojr/eks-infrastructure/blob/main/images/deployments_V.png)
![configmaps](https://github.com/tuyojr/eks-infrastructure/blob/main/images/configmaps.png)
![configmaps_II](https://github.com/tuyojr/eks-infrastructure/blob/main/images/configmaps_II.png)
![namespaces](https://github.com/tuyojr/eks-infrastructure/blob/main/images/namespaces.png)

## CLASSIC LOADBALANCERS
![loadbalancers](https://github.com/tuyojr/eks-infrastructure/blob/main/images/loadbalancers.png)

## ROUTE53
![route53_output](https://github.com/tuyojr/eks-infrastructure/blob/main/images/route53_output.png)
![route53](https://github.com/tuyojr/eks-infrastructure/blob/main/images/route53.png)

## DEPLOYED APPLICATIONS
![notes-app](https://github.com/tuyojr/eks-infrastructure/blob/main/images/notes-app.png)
![sock-shop](https://github.com/tuyojr/eks-infrastructure/blob/main/images/sock-shop.png)
