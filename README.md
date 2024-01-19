# Description 

This is a poc for EKS cluster blueprints. 

vpc.tf : Creates AWS VPC with public, private subnets  

eks.tf : Creates EKS Cluster with default node group

eks_addons.tf_template : Example how to use boostrap EKS Clusters [AWS blog](https://aws.amazon.com/blogs/containers/bootstrapping-clusters-with-eks-blueprints/)

eks_node_group.tf_template: Provides a template to create managed node group using terraform [terraform repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group)
