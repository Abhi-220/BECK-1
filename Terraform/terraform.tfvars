project_id = "terraform-449405"
region = "asia-south1"

network_name = "beckn-network"
network_description = "network for beckn"

subnet_name = "beckn-gke-subnet"
subnet_description = "subnet for beckn gke"
ip_cidr_range = "10.0.0.0/17"
range_name = "beckn-gke-pods"
ip_range = "10.0.128.0/21"
range_name_1 = "beckn-gke-services"
ip_range_1 = "10.0.136.0/21"



cluster_name = "beckn-cluster"
cluster_description = "cluster for beckn"
initial_node_count = "1"
master_ipv4_cidr_block = "172.0.0.0/28"
master_access_cidr_block = "0.0.0.0/0"
display_name = "beckn cluster access IPs"



node_pool_name = "beckn-node-pool"
reg_node_location = [ "asia-south1-a", "asia-south1-b", "asia-south1-c" ]  
max_pods_per_node = "50"
disk_size = "50"
disk_type = "pd-standard"
image_type = "cos_containerd"
pool_labels = {
  env = "dev"
}
machine_type = "e2-standard-2"
node_service_account = "823923309863-compute@developer.gserviceaccount.com"
node_count = "1"
min_node_count = "1"
max_node_count = "2"

nginix_namespace_name = "ingress-nginx"

router_name = "beckn-router"
router_description = "router for beckn"

nat_name = "beckn-nat"



nginix_ingress_release_name = "ingress-nginx"
nginix_ingress_repository = "https://kubernetes.github.io/ingress-nginx"
nginix_ingress_chart = "ingress-nginx"


health_check_name = "beckn-health-check"
health_check_description = "health check for beckn"


backend_service_name = "beckn-backend-service"
backend_service_description = "backend service for beckn"


http_firewall_name = "beckn-allow-http"
http_firewall_description = "allow http for beckn"
http_firewall_direction = "INGRESS"
http_allow_protocols = "tcp"
http_allow_ports = [80]
source_ranges = [ "35.191.0.0/16" ]


global_ip_name = "beckn-global-lb-ip"
global_ip_description = "ip for beckn lb"
global_ip_labels = {
  "name" = "beckn-lb-ip"
}


url_map_name = "beckn-url-map"
url_map_description = "url map for beckn"


http_proxy_name = "beckn-lb"
http_proxy_description = "http proxy for beckn"


frontend_name = "beckn-frontend"
frontend_description = "frontend for beckn"
frontend_port = "80"
