#Highstate, no orchestration
base:
  "roles:db":
    - match: grain
    - database
  "G@roles:api not G@roles.db":
    - match: compound
    - application
