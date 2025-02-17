locals {
  tags = {
    "Team"        = var.teamname
    "Environment" = var.environment
  }
  prefix = "${var.teamname}-${var.environment}"
}

