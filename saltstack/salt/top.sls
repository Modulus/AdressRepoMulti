base:
  "roles:db":
    - match: grain
    - mongodb
    - python.mongodb
    - mongodb.import
  "G@roles:api not G@roles.db":
    - match: compound
    - tools.node
    - nodeapp
