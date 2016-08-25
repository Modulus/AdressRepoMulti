pip-install:
  pkg.installed:
    - name: python-pip

pip upgrade:
  cmd.run:
    - name: pip install -U pip
    - require:
      - pkg: pip-install
