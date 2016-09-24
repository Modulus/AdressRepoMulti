# orchestration of the whole environment

setup master:
  salt.state:
    - tgt: roles:master
    - tgt_type: grain
    - sls:
      - salt-master
    - require_in:
      - salt: setup security groups

setup security groups:
  salt.state:
    - tgt: roles:master
    - tgt_type: grain
    - sls:
        - orch.security_groups_base
        - orch.security_groups_web
    - require_in:
      - salt: setup db minion
      - salt: setup api minion

setup db minion:
  salt.state:
    - tgt: roles:db
    - tgt_type: grain
    - sls:
      - database

setup api minion:
  salt.state:
    - tgt: G@roles:api not G@roles.db
    - tgt_type: compound
    - sls:
      - application
    - require:
      - salt: setup db minion
