python-pip-whl:
  pkg.removed

pip-install:
  pkg.installed:
    - name: python-pip
    - require:
      - pkg: python-pip-whl
    - stateful: True
