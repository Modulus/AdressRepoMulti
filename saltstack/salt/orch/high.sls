# orchestration of the whole environment
setup security groups:
  salt.state:
    - tgt: roles:api
    - tgt_type: grain
    - sls:
        - security_groups
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
