# InstanceGroup-029: Lightsail Container public
# Misconfiguration: container service with public_endpoint exposed

resource "aws_lightsail_container_service" "ig029_container_svc" {
  name  = "ig029-public-container"
  power = "nano"
  scale = 1

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: deployment with public endpoint
resource "aws_lightsail_container_service_deployment_version" "ig029_deployment" {
  service_name = aws_lightsail_container_service.ig029_container_svc.name

  container {
    container_name = "app"
    image          = "nginx:latest"
    ports = {
      "80" = "HTTP"
    }
  }

  public_endpoint {
    container_name = "app"
    container_port = 80

    health_check {
      healthy_threshold   = 2
      interval_seconds    = 5
      path                = "/"
      success_codes       = "200-499"
      timeout_seconds     = 2
      unhealthy_threshold = 2
    }
  }
}
