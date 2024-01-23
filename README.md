# Description 

This is a poc for EKS cluster blueprints. 

* vpc.tf : Creates AWS VPC with public, private subnets  

* eks.tf : Creates EKS Cluster with default node group

* eks_addons.tf_template : Example how to boostrap EKS Clusters [AWS blog](https://aws.amazon.com/blogs/containers/bootstrapping-clusters-with-eks-blueprints/)

* eks_node_group.tf_template: Provides a template to create managed node group using terraform [repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group)

## Pre-requisites [Amazon Linux OS]

1. Terrform utilities
```
   sudo yum install -y yum-utils;
   sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
   sudo yum -y install terraform
```

## Quick Setup 
1. Clone the repo
```
   git clone https://github.com/mirajranpura/eks_poc_terraform.git
   cd eks_poc_terraform/
```
2.  In order to prepare the working directory for use with Terraform, the ```terraform init``` command performs Backend Initialization, Child Module Installation, and Plugin Installation.
```
   terraform init
```
3. Next generate an execution plan, the command will provide what actions will be taken without actually performing the planned actions.
```
   terraform plan
```
4. Create ( or update) infrastructure depending on the configuration files. By default, a plan will be generated first and will need to be approved before it is applied.
```
   terraform apply
```
5. Apply EKS blueprint add-on configurations
```
   # Update kubeconfig to points to newly created cluster.
   aws eks update-kubeconfig --name < Name of the Cluster >

   # Export the variable for K8s terraform module 
   export KUBE_CONFIG_PATH=~/.kube/config

   # Copy template file and adjust the parameters if required
   cp eks_addons.tf_template eks_addons.tf;
   terraform init; # Installs the eks_blueprint module
   terraform plan;
   terraform apply;
```
Ref: [EKS Blueprints](https://aws.amazon.com/blogs/containers/bootstrapping-clusters-with-eks-blueprints/)

6. Create more node groups 
```
   # Copy template with new filename and Adjust the parameters if required eg labels, taints configs
   cp eks_node_group.tf_template web_app_node_group.tf;

   # Replace the nodegroupname with your choice. 
   sed -i 's/nodegroupname/web_app_nodes/g' web_app_node_group.tf
   terraform plan;
   terraform apply;

# Feel free to add more nodegroups by repeating the step 6. 
```

   
