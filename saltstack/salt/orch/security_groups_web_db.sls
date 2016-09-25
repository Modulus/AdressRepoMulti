ensure web security group is present:
  boto_secgroup.present:
    - name: web-sg
    - description: security group for web servers
    - region: {{pillar["aws"]["region"]}}
    - key: {{pillar["aws"]["key"]}}
    - keyid: {{pillar["aws"]["keyid"]}}
    - vpc_name: default
    - rules:
      - ip_protocol: tcp
        from_port: 80
        to_port: 80
        cidr_ip:
          - 0.0.0.0/0
      - ip_protocol: tcp
        from_port: 3000
        to_port: 3000
        cidr_ip:
          - 0.0.0.0/0
      - ip_protocol: tcp
        from_port: 443
        to_port: 443
        cidr_ip:
          - 0.0.0.0/0


ensure db security group is present:
  boto_secgroup.present:
    - name: db-sg
    - description: security group for mongodb servers
    - region: {{pillar["aws"]["region"]}}
    - key: {{pillar["aws"]["key"]}}
    - keyid: {{pillar["aws"]["keyid"]}}
    - vpc_name: default
    - rules:
      - ip_protocol: tcp
        from_port: 27017
        to_port: 27017
        source_group_name: web-sg
    - require:
      - boto_secgroup: ensure web security group is present
