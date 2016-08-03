base:
  "*":
    - docker
    - python
  "roles:db":
    - match: grain
    - mongodb
    - python.mongodb
    - mongodb.import
