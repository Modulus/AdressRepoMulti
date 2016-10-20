# orchestration of the whole environment

setup master:
  salt.state:
    - tgt: roles:master
    - tgt_type: grain
    - sls:
      - salt-master

setup db minion:
  salt.state:
    - tgt: roles:db
    - tgt_type: grain
    - sls:
      - database
    - require:
      - salt: setup master  

setup api minion:
  salt.state:
    - tgt: G@roles:api
    - tgt_type: compound
    - sls:
      - application
    - require:
      - salt: setup db minion
