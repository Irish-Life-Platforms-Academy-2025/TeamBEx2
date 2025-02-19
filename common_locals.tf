locals {

  environment = terraform.workspace
  tags = {
    "Team"        = var.teamname
    "Environment" = local.environment
  }
  prefix      = "${var.teamname}-${local.environment}"
  custom_data = <<CUSTOM_DATA
  #cloud-config
  runcmd:
    - sudo apt install -y apache2
  CUSTOM_DATA
}



