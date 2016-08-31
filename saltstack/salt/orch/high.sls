setup db minion:
  salt.state:
    - tgt: roles:db
    - tgt_type: grain
    - sls:
      - mongodb
      - python.mongodb
      - mongodb.import

setup api minion:
  salt.state:
    - tgt: G@roles:api not G@roles.db
    - tgt_type: compound
    - highstate: True
    - require:
      - salt: setup db minion
