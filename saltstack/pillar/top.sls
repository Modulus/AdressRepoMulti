base:
  "*":
    - docker
    - amazon
    - mine
  "minion*":
    - elastic
  "roles:master":
    - match: grain
    - elastic
