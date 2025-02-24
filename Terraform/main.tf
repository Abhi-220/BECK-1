# Provider Block
provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_project" "project" {
  project_id = var.project_id
}


module "network" {
  source = "./VPC"

  network_name = var.network_name
  network_description = var.network_description 

  subnet_name        = var.subnet_name
  subnet_description = var.subnet_description
  ip_cidr_range = var.ip_cidr_range
  range_name = var.range_name
  ip_range = var.ip_range
  range_name_1 = var.range_name_1
  ip_range_1 = var.ip_range_1
  region = var.region
}

output "network_name" {
  value = module.network.network_name
}

output "subnet_name" {
  value = module.network.subnet_name
  
}

output "ip_cidr_range" {
  value = module.network.ip_cidr_range
}


output "range_name" {
  value = module.network.range_name
}

output "range_name_1" {
  value = module.network.range_name_1
}


module "gke" {
  source = "./GKE"

  cluster_name = var.cluster_name
  cluster_region =  var.region
  #cluster_ipv4_cidr = module.network.ip_cidr_range
  cluster_description = var.cluster_description
  #default_max_pods_per_node = var.default_max_pods_per_node
  initial_node_count = var.initial_node_count

  network = "projects/${data.google_project.project.project_id}/global/networks/${module.network.network_name}"
  subnetwork = "projects/${data.google_project.project.project_id}/regions/${var.region}/subnetworks/${module.network.subnet_name}"

  workload_pool = "${data.google_project.project.project_id}.svc.id.goog"

  cluster_secondary_range_name = module.network.range_name
  services_secondary_range_name = module.network.range_name_1

  master_ipv4_cidr_block = var.master_ipv4_cidr_block

  master_access_cidr_block = var.master_access_cidr_block
  display_name = var.display_name

  depends_on = [ module.network ]
}


output "cluster_name" {
  value = module.gke.cluster_name
}

module "gke_node_pool" {
  source = "./GKE_NODE_POOL"

  cluster_name = module.gke.cluster_name
  node_pool_name = var.node_pool_name
  node_pool_location = var.region
  project_id = data.google_project.project.project_id
  reg_node_location = var.reg_node_location
  max_pods_per_node = var.max_pods_per_node
  disk_size = var.disk_size
  disk_type = var.disk_type
  image_type = var.image_type
  pool_labels = var.pool_labels
  machine_type = var.machine_type
  node_service_account = var.node_service_account
  node_count = var.node_count
  min_node_count = var.min_node_count
  max_node_count = var.max_node_count

  depends_on = [ module.gke, module.network ] 
}

output "cluster_endpoint" {
  value = module.gke.cluster_endpoint
  #sensitive = false
}

output "ca_certificate" {
  value = module.gke.ca_certificate
  sensitive = true
}

data "google_client_config" "default" {}

output "access_token" {
  value = data.google_client_config.default.access_token
  sensitive = true # Prevent the token from being displayed in the UI
}

/**
resource "null_resource" "gke_credentials" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials beckn-cluster --region ${var.region} --project ${var.project_id}"
  }

  triggers = {
    cluster_name = module.gke.cluster_name
  }
}
**/

provider "kubernetes" {
  host = "https://${module.gke.cluster_endpoint}"
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  token = data.google_client_config.default.access_token
}

module "router" {
  source = "./CLOUD_NAT/COMPUTE_ROUTER"
  router_name = var.router_name
  network_name = module.network.network_name
  router_description = var.router_description
  router_region = var.region

  depends_on = [ module.network ]
}

output "router_name" {
  value = module.router.router_name
}

module "router_nat" {
  source = "./CLOUD_NAT/COMPUTE_ROUTER_NAT"
  nat_name = var.nat_name
  router_name = module.router.router_name
  nat_region = var.region
  project_id = data.google_project.project.project_id
  depends_on = [ module.router, module.network ]
}

provider "helm" {
  kubernetes {
  host = "https://${module.gke.cluster_endpoint}"
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  token = data.google_client_config.default.access_token
  }
}

module "helm_config" {
  source = "./HELM/HELM_CONFIG"
  endpoint = "https://${module.gke.cluster_endpoint}"
  ca_certificate = base64decode(module.gke.ca_certificate)
  access_token = data.google_client_config.default.access_token
}

module "nginx_namepsace"{
  source = "./NAMESPACE"
  namespace_name = var.nginix_namespace_name
  depends_on = [ module.gke, module.gke_node_pool]
}


module "nginx_ingress" {
  source = "./HELM/HELM_RELEASES"
  helm_name = var.nginix_ingress_release_name
  helm_repository = var.nginix_ingress_repository
  helm_namespace = var.nginix_namespace_name
  helm_chart = var.nginix_ingress_chart
  helm_values = [
    file("./CONFIG_FILES/nginx.conf")
  ]
  depends_on = [ module.gke, module.gke_node_pool, module.helm_config ]
}


module "health_check" {
  source = "./HEALTH_CHECK"
  health_check_name = var.health_check_name
  health_check_description = var.health_check_description
  depends_on = [ module.network ]
}

output "health_check_name" {
  value = module.health_check.health_check_name
}


module "backend_service" {
  source = "./LOAD_BALANCER/BACKEND"
  backend_name = var.backend_service_name
  backend_description = var.backend_service_description
  group_1 = "projects/${data.google_project.project.project_id}/zones/${var.region}-a/networkEndpointGroups/ingress-nginx-internal-80-neg-http"
  group_2 = "projects/${data.google_project.project.project_id}/zones/${var.region}-b/networkEndpointGroups/ingress-nginx-internal-80-neg-http" 
  group_3 = "projects/${data.google_project.project.project_id}/zones/${var.region}-c/networkEndpointGroups/ingress-nginx-internal-80-neg-http"
  health_check = ["projects/${data.google_project.project.project_id}/global/healthChecks/${module.health_check.health_check_name}"]
  #security_policy = "projects/${var.project_id}/global/securityPolicies/default-security-policy-for-backend-service-${var.backend_service_name}"
  depends_on = [ module.gke, module.health_check, module.gke_node_pool, module.nginx_ingress ]
}

output "backend_id" {
  value = module.backend_service.backend_id
}

module "http_rule" {
  source = "./VPC/FIREWALL_ALLOW"
  firewall_name = var.http_firewall_name
  firewall_description = var.http_firewall_description
  vpc_network_name = module.network.network_name
  firewall_direction = var.http_firewall_direction
  allow_protocols = var.http_allow_protocols
  allow_ports = var.http_allow_ports
  source_ranges = var.source_ranges
  depends_on = [ module.network ]
}

module "lb_global_ip"{
  source = "./COMPUTE_ENGINE/GLOBAL_ADDRESS"
  global_ip_name = var.global_ip_name
  global_ip_description = var.global_ip_description
  global_ip_labels = var.global_ip_labels
}

output "global_ip_address" {
  value = module.lb_global_ip.global_ip_address
  
}

module "url_map" {
  source = "./LOAD_BALANCER/URL_MAP"
  url_map_name = var.url_map_name
  backend_service_id = module.backend_service.backend_id
  url_map_description = var.url_map_description
  depends_on = [ module.backend_service ]
}

output "url_map" {
  value = module.url_map.url_map 
}

module "target_proxy" {
  source = "./LOAD_BALANCER/HTTP_PROXY"
  proxy_name = var.http_proxy_name
  url_map_id = module.url_map.url_map
  proxy_description = var.http_proxy_description
  depends_on = [ module.url_map ]
}

output "target_http_proxy" {
  value = module.target_proxy.target_http_proxy
}

module "forwarding_rule" {
  source = "./LOAD_BALANCER/FRONTEND"
  frontend_name = var.frontend_name
  frontend_description = var.frontend_description
  frontend_ip = module.lb_global_ip.global_ip_address
  frontend_port = var.frontend_port
  target_proxy_id  = module.target_proxy.target_http_proxy
  
  depends_on = [ module.target_proxy, module.lb_global_ip ]
  
}






