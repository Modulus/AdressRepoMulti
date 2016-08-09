base:
  "*":
    - docker
    - python
  "roles:db":
    - match: grain
    - mongodb
    - python.mongodb
    - mongodb.import
  "G@roles:api":
    - match: compound
    - tools.node
    - nodeapp
