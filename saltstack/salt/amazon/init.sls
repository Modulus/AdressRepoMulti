#Run this with the salt-run function, you have to run this twice the first time beacuse of the entaglement
include:
  - python
  - python.boto

web security group present:
  boto_secgroup.present:
    - name: demo-web
    - description: security group for web servers
    - profile: aws
    - require:
      - pip: boto
    - rules:
      - ip_protocol: tcp
        from_port: 80
        to_port: 80
        cidr_ip:
          - 0.0.0.0/0


master security group present:
  boto_secgroup.present:
    - name: demo-master
    - description: security group for salt master to communicate with other masters or minions
    - profile: aws
    - require:
      - pip: boto
    - rules:
      - ip_protocol: tcp
        from_port: 22
        to_port: 22
        source_group_name: demo-minion
      - ip_protocol: tcp
        from_port: 4505
        to_port: 4506
        source_group_name: demo-minion


minion security group present:
  boto_secgroup.present:
    - name: demo-minion
    - description: security group for salt minions to communicate with other minions or masters
    - profile: aws
    - require:
      - pip: boto
    - rules:
      - ip_protocol: tcp
        from_port: 22
        to_port: 22
        source_group_name: demo-master
      - ip_protocol: tcp
        from_port: 4505
        to_port: 4506
        source_group_name: demo-master
