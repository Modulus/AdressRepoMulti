# Create empty security groups
ensure salt-master security group exists:
  boto_secgroup.present:
    - name: salt-master-sg
    - description: temp security group, will be completed shortly
    - region: {{pillar["aws"]["region"]}}
    - key: {{pillar["aws"]["key"]}}
    - keyid: {{pillar["aws"]["keyid"]}}
    - vpc_name: default

ensure salt-minion security group exists:
  boto_secgroup.present:
    - name: salt-minion-sg
    - description: temp security group, will be completed shortly
    - region: {{pillar["aws"]["region"]}}
    - key: {{pillar["aws"]["key"]}}
    - keyid: {{pillar["aws"]["keyid"]}}
    - vpc_name: default

# Initalize security groups with connections between them
ensure salt-master security groups is configured:
  boto_secgroup.present:
    - name: salt-master-sg
    - description: Security group for salt-master
    - region: {{pillar["aws"]["region"]}}
    - key: {{pillar["aws"]["key"]}}
    - keyid: {{pillar["aws"]["keyid"]}}
    - vpc_name: default
    - rules:
        - ip_protocol: tcp
          from_port: 4505
          to_port: 4506
          source_group_name: salt-minion-sg
    - require:
      - boto_secgroup: ensure salt-minion security group exists
      - boto_secgroup: ensure salt-master security group exists


ensure salt-minion security groups is configured:
  boto_secgroup.present:
    - name: salt-minion-sg
    - description: Security group for salt-minins
    - region: {{pillar["aws"]["region"]}}
    - key: {{pillar["aws"]["key"]}}
    - keyid: {{pillar["aws"]["keyid"]}}
    - vpc_name: default
    - rules:
        - ip_protocol: tcp
          from_port: 4505
          to_port: 4506
          source_group_name: salt-master-sg
        - ip_protocol: tcp
          from_port: 4505
          to_port: 4506
          source_group_name: salt-minion-sg
    - require:
      - boto_secgroup: ensure salt-minion security group exists
      - boto_secgroup: ensure salt-master security group exists
