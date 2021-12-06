resource "azurerm_resource_group" "k8s" {
    name     = var.resource_group_name
    location = var.location
}

resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}

resource "azurerm_log_analytics_workspace" "test" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = var.log_analytics_workspace_location
    resource_group_name = azurerm_resource_group.k8s.name
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "test" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.test.location
    resource_group_name   = azurerm_resource_group.k8s.name
    workspace_resource_id = azurerm_log_analytics_workspace.test.id
    workspace_name        = azurerm_log_analytics_workspace.test.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                = var.cluster_name
    location            = azurerm_resource_group.k8s.location
    resource_group_name = azurerm_resource_group.k8s.name
    dns_prefix          = var.dns_prefix

    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDmK/thfF1HjePbsHWtMmmHGKn2LG6MJqYD0BAhNRu4oXiFMUhL65I5uSVj9C1g2ivF4BZKMpZ6hYMI43Of6xlGqWdXD+teT/oST5m1k3T31iziSHdf2wElPRDGVBUUtAONHoEa/P4n9cmvbxOPeLwYnFah1EswR1dwWgTLTqUpVYkSL5EW18BVXij3CVsTV5Q4atWUORrp6RnDiuL+WXypGl34uREtAaBK0l03fVupXBzHvOfa5vYMMGQFtGGWo95ZUG4Nuvwd17zsBCz6Y9t7A2TUtE+pDivVHO5zguvu3HWu/Ians+JP5AU/2R+AMjeG17piiEyvScEt82hjYnZsQeiqnYLzj3JKrMoOhNG7tuLSChcaroE8VY19nUAR2Yn5HbEvu1KSvEHICOo86h2QIP2rZoVB3PhcR8NvzbRQxWI6yNEd2IwHBnS17oBgtpVUD3xQOVu/6dTZr0eETgjlz2odFyk+oWsVFwsdVMWSmzdi+x7YnSBi88tvKFAaswf6sJH2WIXKJsZ6zDin7tZQw0pxRwg50bUu5Syp62eVvKo2u0rSjNsN4/MJOSPYBYqnpaewXFl33JY5nsUNn7cAYEwB5z79ATVOZ2HK9MzmMsnbLg4YX4Wn762unvl3eglWTQbTzQo12iB9GthIULG6IEXoo75DCVF1bFnkblUxow== azureuser@cc-d74f79c6-dcd88976b-hrjb6"
        }
    }

    default_node_pool {
        name            = "agentpool"
        node_count      = var.agent_count
        vm_size         = "Standard_D2_v2"
    }

    service_principal {
        client_id     = var.client_id
        client_secret = var.client_secret
    }

    addon_profile {
        oms_agent {
        enabled                    = true
        log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
        }
    }

    network_profile {
        load_balancer_sku = "Standard"
        network_plugin = "kubenet"
    }

    tags = {
        Environment = "Development"
    }
}