locals {
  tags = {
    "Team"        = var.teamname
    "Environment" = var.environment
  }
  prefix      = "${var.teamname}-${var.environment}"
  custom_data = <<CUSTOM_DATA
  #cloud-config
  runcmd:
    - sudo apt install -y apache2
  CUSTOM_DATA
}


