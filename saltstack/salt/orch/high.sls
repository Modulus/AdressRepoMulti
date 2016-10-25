# orchestration of the whole environment

setup master:
  salt.state:
    - tgt: roles:master
    - tgt_type: grain
    - sls:
      - salt-master

setup security groups:
  salt.state:
    - tgt: roles:master
    - tgt_type: grain
    - sls:
        - orch.security_groups_base
        - orch.security_groups_web_db
    - require_in:
      - salt: setup db minion
      - salt: setup api minion
    - require:
      - salt: setup master

setup db minion:
  salt.state:
    - tgt: roles:db
    - tgt_type: grain
    - sls:
      - database

setup api minion:
  salt.state:
    - tgt: G@roles:api
    - tgt_type: compound
    - sls:
      - application
    - require:
      - salt: setup db minion
