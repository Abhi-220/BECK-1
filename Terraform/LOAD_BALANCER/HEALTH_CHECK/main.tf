resource "google_compute_health_check" "health_check" {

    name = var.health_check_name
    # Health Check Name

    #check_interval_sec = var.check_interval_sec 
    #How often (in seconds) to send a health check. The default value is 5 seconds.

    description = var.health_check_description
    # Description for the health check

    #healthy_threshold = var.healthy_threshold   
    #A so-far unhealthy instance will be marked healthy after this many consecutive successes. The default value is 2.


    #timeout_sec = var.timeout_sec               
    # How long (in seconds) to wait before claiming failure. The default value is 5 seconds. It is invalid for timeoutSec to have greater value than checkIntervalSec.

    #unhealthy_threshold = var.unhealthy_threshold 
    # A so-far healthy instance will be marked unhealthy after this many consecutive failures. The default value is 2.

    http_health_check {
      # host = The value of the host header in the HTTP health check request. 
               #If left empty (default value), the public IP on behalf of which this health check is performed will be used

      request_path = var.request_path  
      #  "/helathz" #The request path of the HTTP health check request. The default value is /.

      port = var.health_check_port  #The TCP port number for the HTTP health check request. The default value is 80.

      #port_name = Port name as defined in InstanceGroup#NamedPort#name. If both port and port_name are defined, port takes precedence. 

      #port_specification = var.port_specification #Optional
      
      # Specifies how port is selected for health checking, can be one of the following values:
      # USE_FIXED_PORT: The port number in port is used for health checking.
      # USE_NAMED_PORT: The portName is used for health checking.
      # USE_SERVING_PORT: For NetworkEndpointGroup, the port specified for each network endpoint is used for health checking. For other backends, the port or named port specified in the Backend Service is used for health checking. 
    }
}