base:
  "*":
    - docker
  "roles:db":
    - docker.elk
    - match: grain
