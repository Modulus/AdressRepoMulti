#Run this with the salt-run function
include:
  - python
  - python.boto

web security group present:
  boto_secgroup.present:
    - name: demo-web
    - description: security group for web servers
    - profile: ec2
    - rules:
      - ip_protocol: tcp
        from_port: 80
        to_port: 80
        cidr_ip:
          - 0.0.0.0/0

master security group present:
  boto_secgroup.present:
    - name: demo-master
    - description: security group for web servers
    - profile: ec2
    - rules:
      - ip_protocol: tcp
        from_port: 4505
        to_port: 4506
        source_group_name: demo-minion
      - ip_protocol: tcp
        from_port: 4505
        to_port: 4506
        source_group_name: demo-master


minion security group present:
  boto_secgroup.present:
    - name: demo-minion
    - description: security group for web servers
    - profile: ec2
    - rules:
      - ip_protocol: tcp
        from_port: 4505
        to_port: 4506
        source_group_name: demo-minion
      - ip_protocol: tcp
        from_port: 4505
        to_port: 4506
        source_group_name: demo-master
