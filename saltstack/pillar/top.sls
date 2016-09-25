base:
  "*":
    - amazon
    - mine
  "minion*":
    - elastic
  "roles:master":
    - match: grain
    - elastic
  "G@roles:web or minion2 or G@roles:master or G@roles:db or G@roles:api":
    - match: compound
    - home
    - users
