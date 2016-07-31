mine_functions:
  network.ip_addrs:
    interface: eth1
  network.private_hostname:
    mine_function: grains.get
    key: fqdn
mine_interval: 1
