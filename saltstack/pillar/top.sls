base:
  "*":
    - amazon
    - mine
  "minion*":
    - elastic
  "roles:master":
    - match: grain
    - elastic
  "G@roles:web or minion2":
    - match: compound
    - home
