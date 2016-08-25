include:
  - python

pymongo:
  pip.installed:
    - unless: pip freeze | grep "^pymongo=="
    - require:
      - pkg: pip-install
