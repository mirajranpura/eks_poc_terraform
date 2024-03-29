variable "cluster_name" {
  type    = string
  default = "vcloud-workshop"
}

variable "cluster_version" {
  description = "EKS cluster version."
  type        = string
  default     = "1.27"
}

variable "ami_release_version" {
  description = "Default EKS AMI release version for node groups"
  type        = string
  default     = "1.27.9-20240110"
}

variable "vpc_cidr" {
  description = "Defines the CIDR block used on Amazon VPC created for Amazon EKS."
  type        = string
  default     = "172.20.0.0/16"
}

variable "vpc_secondary_cidr" {
  description = "Defines the CIDR block used on Amazon VPC created for Amazon EKS."
  type        = list(string)
  default     = ["100.64.0.0/16"]
}
