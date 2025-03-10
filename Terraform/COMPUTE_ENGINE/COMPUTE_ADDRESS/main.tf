resource "google_compute_address" "external_ip_address" {
    name = var.ip_name  # Name allocated to your IP address 
                     # REQUIRED
    #address = var.address  # The static external IP address represented by this resource.
                           # Set by the API if undefined.
                           # OPTIONAL
    address_type = var.address_type # The type of address to reserve. INTERNAL OR EXTERNAL
                                    # Possible values INTERNAL and EXTERNAL. DEFAULTS to EXTERNAL
                                    # If set to INTERNAL skip the NETWORK_TIER block
                                    # OPTIONAL
    description = var.description # Description for this resource 
                                  # OPTIONAL
    labels = var.ip_labels # Labels to apply to this address. A list of key->value pairs. Example: {name = "webserver"}
    network_tier = var.ip_network_tier # The networking tier used for configuring this address.
                                       # Should not be used when configuring Internal addresses
                                       # Possible values STANDARD and PREMIUM
                                       # OPTIONAL
    ip_version = var.ip_version # The IP Version that will be used by this address.
                                # Default IPv4, Possible Values IPv4, IPv6
                                # OPTIONAL
    
    purpose = var.ip_purpose # The purpose of this resource. 
                             # Possible values GCE_ENDPOINT, SHARED_LOADBALANCER_VIP, VPC_PEERING, NAT_AUTO, 
                             # NAT_MANUAL, VPN, GKE_CLUSTER, GKE_SERVICE, GCE_INTERNAL, GCE_EXTERNAL, 
                             # GCE_EXTERNAL_RESERVATION, GCE_UNASSIGNED, GCE_INTERNAL_RESERVATION
                             # OPTIONAL
    #region = var.ip_region
    
}