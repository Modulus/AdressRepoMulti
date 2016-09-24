ensure web security group is present:
  web security group present:
    boto_secgroup.present:
      - name: web-sg
      - description: security group for web servers
      - region: {{pillar["aws"]["region"]}}
      - key: {{pillar["aws"]["key"]}}
      - keyid: {{pillar["aws"]["keyid"]}}
      - rules:
          - ip_protocol: tcp
            from_port: 80
            to_port: 80
            cidr_ip:
              - 0.0.0.0/0
          - ip_protocol: tcp
            from_port: 443
            to_port: 443
            cidr_ip:
              - 0.0.0.0/0
