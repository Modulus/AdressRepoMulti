base:
  "*":
    - docker
    - python
    - python.elastic
  "roles:db":
    - match: grain
    - docker.elk
