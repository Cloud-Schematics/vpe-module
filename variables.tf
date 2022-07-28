##############################################################################
# VPC Variables
##############################################################################

variable "region" {
  description = "The region where VPC and services are deployed"
  type        = string
}

variable "prefix" {
  description = "The prefix that you would like to prepend to your resources"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC where the Endpoint Gateways will be created. This value is used to dynamically generate VPE names."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the Endpoint Gateways will be created"
  type        = string
}

variable "subnet_zone_list" {
  description = "List of subnets in the VPC where gateways and reserved IPs will be provisioned. This value is intended to use the `subnet_zone_list` output from the ICSE VPC Subnet Module (https://github.com/Cloud-Schematics/vpc-subnet-module) or from templates using that module for subnet creation."
  type = list(
    object({
      name = string
      id   = string
      zone = optional(string)
      cidr = optional(string)
    })
  )
}

##############################################################################

##############################################################################
# VPE Variables
##############################################################################

variable "resource_group_id" {
  description = "ID of the resource group where endpoint gateways will be provisioned"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of security group ids to attach to each endpoint gateway."
  type        = list(string)
  default     = null
}


variable "cloud_services" {
  description = "List of cloud services to create an endpoint gateway."
  type        = list(string)
  default     = ["kms", "cloud-object-storage"]

  validation {
    error_message = "Currently the only supported services are Key Protect (`kms`), Cloud Object Storage (`cloud-object-storage`), and Hyper Protect Crypto Services (`hs-crypto`)."
    condition = length(var.cloud_services) == 0 ? true : length([
      for service in var.cloud_services :
      service if !contains([
        "kms",
        "hs-crypto",
        "cloud-object-storage",
        "container-registry"
      ], service)
    ]) == 0
  }
}

variable "service_endpoints" {
  description = "Service endpoints to use to create endpoint gateways. Can be `public`, or `private`."
  type        = string
  default     = "private"

  validation {
    error_message = "Service endpoints can only be `public` or `private`."
    condition     = contains(["public", "private"], var.service_endpoints)
  }
}

##############################################################################