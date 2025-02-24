variable "project_id" {
    type = string
    description = "The project ID to deploy resources"
}

variable "region" {
    type = string
    description = "The region to deploy resources"
}


variable "network_name" {
    type = string
    description = "The name of the network"
}

variable "network_description" {
    type = string
    description = "The description of the network"
}


variable "subnet_name" {
    type = string
    description = "The name of the subnet"
}

variable "subnet_description" {
    type = string
    description = "The description of the subnet"
}

variable "ip_cidr_range" {
    type = string
    description = "The IP CIDR range of the subnet"
}

variable "range_name" {
    type = string
    description = "The name of the secondary range"
}

variable "ip_range" {
    type = string
    description = "The IP CIDR range of the secondary range"
}   

variable "range_name_1" {
    type = string
    description = "The name of the secondary range"
}

variable "ip_range_1" {
    type = string
    description = "The IP CIDR range of the secondary range"
}






variable "cluster_name" {
    type = string
    description = "The name of the GKE cluster"
}

variable "cluster_description" {
    type = string
    description = "The description of the GKE cluster"
}

variable "initial_node_count" {
    type = string
    description = "The initial number of nodes in the GKE cluster"
}

variable "master_ipv4_cidr_block" {
    type = string
    description = "The IP CIDR range of the master"
}


variable "master_access_cidr_block" {
    type = string
    description = "The IP CIDR range of the master"
}

variable "display_name" {
    type = string
    description = "The display name of the GKE cluster"
}




variable "node_pool_name" {
    type = string
    description = "The name of the node pool"
}

variable "reg_node_location" {
    type = list(string)
    description = "The region of the node pool"
}

variable "max_pods_per_node" {
    type = string
    description = "The maximum number of pods per node"
}

variable "disk_size" {
    type = string
    description = "The disk size of the node pool"
}

variable "disk_type" {
    type = string
    description = "The disk type of the node pool"
}

variable "image_type" {
    type = string
    description = "The image type of the node pool"
}

variable "pool_labels" {
    type = map(string)
    description = "The labels of the node pool"
}

variable "machine_type" {
    type = string
    description = "The machine type of the node pool"
}

variable "node_service_account" {
    type = string
    description = "The service account of the node pool"
}

variable "node_count" {
    type = string
    description = "The number of nodes in the node pool"
}

variable "min_node_count" {
    type = string
    description = "The minimum number of nodes in the node pool"
}

variable "max_node_count" {
    type = string
    description = "The maximum number of nodes in the node pool"
}




variable "router_name" {
    type = string
    description = "The name of the router"
}

variable "router_description" {
    type = string
    description = "The description of the router"
}


variable "nat_name" {
    type = string
    description = "The name of the NAT"
}

variable "nginix_namespace_name" {
    type = string
    description = "The name of the namespace"
}


variable "nginix_ingress_release_name" {
    type = string
    description = "The name of the helm release"
}


variable "nginix_ingress_repository" {
    type = string
    description = "The repository of the helm release"
}


variable "nginix_ingress_chart" {
    type = string
    description = "The chart of the helm release"
}


variable "health_check_name" {
    type = string
    description = "The name of the health check"
}

variable "health_check_description" {
    type = string
    description = "The description of the health check"
}



variable "backend_service_name" {
    type = string
    description = "The name of the backend service"
}

variable "backend_service_description" {
    type = string
    description = "The description of the backend service"
  
}

variable "http_firewall_name" {
    type = string
    description = "The name of the firewall rule"
}

variable "http_firewall_description" {
    type = string
    description = "The description of the firewall rule"
}

variable "http_firewall_direction" {
    type = string
    description = "The direction of the firewall rule"
}   

variable "http_allow_protocols" {
    type = string
    description = "The protocol to allow"
}

variable "http_allow_ports" {
    type = list(number)
    description = "The list of ports to allow"
    default = []
}

variable "source_ranges" {
    type = list(string)
    description = "The list of IP ranges in CIDR format that the rule applies to"
    default = []
}


variable "global_ip_name" {
    type = string
    description = "The name of the global IP"
}

variable "global_ip_description" {
    type = string
    description = "The description of the global IP"
}

variable "global_ip_labels" {
    type = map(string)
    description = "The labels of the global IP"
}




variable "url_map_name" {
    type = string
    description = "The name of the URL map"
}

variable "url_map_description" {
    type = string
    description = "The description of the URL map"
}



variable "http_proxy_name" {
    type = string
    description = "The name of the HTTP proxy"
}

variable "http_proxy_description" {
    type = string
    description = "The description of the HTTP proxy"
}


variable "frontend_name" {
    type = string
    description = "The name of the frontend"
}

variable "frontend_description" {
    type = string
    description = "The description of the frontend"
}

variable "frontend_port" {
    type = number
    description = "The port of the frontend"
}

