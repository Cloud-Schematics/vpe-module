# Virtual Private Endpoint for VPC Module

This module creates Reserved IPs, Virtual Endpoint Gateways, and Endpoint Gateway IPs for any number of subnets in a single VPC.


To read more about using Virtual Private Endpoint Gateways refer to the documentation [here](https://cloud.ibm.com/docs/vpc?topic=vpc-about-vpe).

---

## Supported Services

- Cloud Object Storage (`cloud-object-storage`)
- HyperProtect Crypto Services (`hs-crypto`)
- Key Protect (`kms`)
- IBM Container Registry (`container-registry`)

---

## Module Variables

Name               | Type                                                                                          | Description                                                                                                                                                                                                                                                                                  | Sensitive | Default
------------------ | --------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | -------------------------------
region             | string                                                                                        | The region where VPC and services are deployed                                                                                                                                                                                                                                               |           | 
prefix             | string                                                                                        | The prefix that you would like to prepend to your resources                                                                                                                                                                                                                                  |           | 
vpc_name           | string                                                                                        | Name of the VPC where the Endpoint Gateways will be created. This value is used to dynamically generate VPE names.                                                                                                                                                                           |           | 
vpc_id             | string                                                                                        | ID of the VPC where the Endpoint Gateways will be created                                                                                                                                                                                                                                    |           | 
subnet_zone_list   | list( object({ name = string id = string zone = optional(string) cidr = optional(string) }) ) | List of subnets in the VPC where gateways and reserved IPs will be provisioned. This value is intended to use the `subnet_zone_list` output from the [ICSE VPC Subnet Module](https://github.com/Cloud-Schematics/vpc-subnet-module) or from templates using that module for subnet creation.|           | 
resource_group_id  | string                                                                                        | ID of the resource group where endpoint gateways will be provisioned                                                                                                                                                                                                                         |           | null
security_group_ids | list(string)                                                                                  | List of security group ids to attach to each endpoint gateway.                                                                                                                                                                                                                               |           | []
cloud_services     | list(string)                                                                                  | List of cloud services to create an endpoint gateway.                                                                                                                                                                                                                                        |           | ["kms", "cloud-object-storage"]
service_endpoints  | string                                                                                        | Service endpoints to use to create endpoint gateways. Can be `public`, or `private`.                                                                                                                                                                                                         |           | private