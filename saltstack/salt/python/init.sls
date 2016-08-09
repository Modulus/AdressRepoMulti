python-pip-whl:
  pkg.removed

pip-install:
  pkg.installed:
    - name: python-pip
    - require:
      - pkg: python-pip-whl
    - stateful: True


pip upgrade:
  cmd.run:
    - name: pip install -U pip
    - require:
      - pkg: pip-install
