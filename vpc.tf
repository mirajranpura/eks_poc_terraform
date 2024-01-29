locals {
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 3, k + 3)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 3, k)]
  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  pod_subnets = [for k, v in local.azs : cidrsubnet(element(var.vpc_secondary_cidr, 0), 3, k + 3)]
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.1"

  name = var.cluster_name
  cidr = var.vpc_cidr
  
  secondary_cidr_blocks = var.vpc_secondary_cidr

  azs                   = local.azs
  public_subnets        = local.public_subnets
  private_subnets       = local.private_subnets
  public_subnet_suffix  = "SubnetPublic"
  private_subnet_suffix = "SubnetPrivate"

  enable_nat_gateway   = true
  create_igw           = true
  enable_dns_hostnames = true
  single_nat_gateway   = true

  # Manage so we can name
  manage_default_network_acl    = true
  default_network_acl_tags      = { Name = "${var.cluster_name}-default" }
  manage_default_route_table    = true
  default_route_table_tags      = { Name = "${var.cluster_name}-default" }
  manage_default_security_group = true
  default_security_group_tags   = { Name = "${var.cluster_name}-default" }

  public_subnet_tags  = merge(local.tags, {
    "kubernetes.io/role/elb" = "1"
  })
  private_subnet_tags = merge(local.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })

  tags = local.tags
}

#resource "aws_subnet" "in_secondary_cidr_pod_0" {
#  vpc_id = module.vpc.vpc_id
#  cidr_block = element(local.pod_subnets,0)
#  availability_zone = element(local.azs,0)
#  tags = merge(local.tags, {
#    "Name" = "pod_network_1"
#  })
#}

#resource "aws_subnet" "in_secondary_cidr_pod_1" {
#  vpc_id = module.vpc.vpc_id
#  cidr_block = element(local.pod_subnets,1)
#  availability_zone = element(local.azs,1)
#  tags = merge(local.tags, {
#    "Name" = "pod_network_2"
#  })
#}

#resource "aws_subnet" "in_secondary_cidr_pod_2" {
#  vpc_id = module.vpc.vpc_id
#  cidr_block = element(local.pod_subnets,2)
#  availability_zone = element(local.azs,2)
#  tags = merge(local.tags, {
#    "Name" = "pod_network_3"
#  })
#}

