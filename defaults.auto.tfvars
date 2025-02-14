location              = "uksouth"
rg_name               = "teamb-terraform-rg"
resource_count        = 3
vm_size               = "Standard_DS1_v2"
prefix                = "teamb"
public_address_space  = "10.1.0.0/16"
private_address_space = "10.0.0.0/16"
vm_username           = "teambadmin"