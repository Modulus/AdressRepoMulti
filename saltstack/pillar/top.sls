base:
  "*":
    - amazon
    - mine
  "G@roles:web or minion2 or G@roles:master or G@roles:db or G@roles:api":
    - match: compound
    - home
    - users
