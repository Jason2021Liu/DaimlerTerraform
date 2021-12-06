variable "resource_group_location" {
  default = "eastus"
  description   = "Location of the resource group."
}

# add for K8S below
variable "client_id" {
     default="6a549e56-4468-44af-8921-9ec3994c2279"
}
variable "client_secret" {
    default="6-O6kejLcmXbM8lfY~OJQgNBapANozI~AQ"
}

variable "agent_count" {
    default =1
}

variable "dns_prefix" {
    default = "k8stest"
}

variable cluster_name {
    default = "k8stest"
}

variable resource_group_name {
    default = "azure-k8stest"
}

variable location {
    default = "Central US"
}

variable log_analytics_workspace_name {
    default = "testLogAnalyticsWorkspaceName"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "eastus"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}