module "create_csr" {
  source                 = ".//cisco_csr"
  buildby                = "Name"
  buildticket            = "Ticket-Number"
  location               = "East US"
  environment            = "Production"
  admin_password         = "RandomPassword$"
  vm_size                = "Standard_D2s_v3"
  csr_count              = 0
  vnet_address_space     = ["172.16.192.0/28"]
  first_subnet_range     = "172.16.192.0/29"
  second_subnet_range    = "172.16.192.8/29"
  accelerated_networking = false
}
