output "cluster_name" {
  value = google_container_cluster.primary_cluster.name
}

output "cluster_endpoint" {
  value = google_container_cluster.primary_cluster.endpoint
}

output "ca_certificate" {
  value = google_container_cluster.primary_cluster.master_auth.0.cluster_ca_certificate
  
}