#############################
# Availability Set
#############################

module "web_avset" {
  source      = ".//availability_set"
  buildby     = "Racker Name"
  buildticket = "Ticket-Number"
  environment = "Production"
  location    = "East US 2"
  rsg         = "LOC-ENV-RSG-DMZ"
  vm_avset    = "LOC-ENV-WEB-AVSET"
}

module "app_avset" {
  source      = ".//availability_set"
  buildby     = "Racker Name"
  buildticket = "Ticket-Number"
  environment = "Production"
  location    = "East US 2"
  rsg         = "LOC-ENV-RSG-APP"
  vm_avset    = "LOC-ENV-APP-AVSET"
}

module "ins_avset" {
  source      = ".//availability_set"
  buildby     = "Racker Name"
  buildticket = "Ticket-Number"
  environment = "Production"
  location    = "East US 2"
  rsg         = "LOC-ENV-RSG-INS"
  vm_avset    = "LOC-ENV-INS-AVSET"
}
