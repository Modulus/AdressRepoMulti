mine_functions:
  network.ip_addrs:
    interface: eth0
  network.private_hostname:
    mine_function: grains.get
    key: fqdn
  mine_interval: 1
