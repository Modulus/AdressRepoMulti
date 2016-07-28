dockerpy:
  pip.installed:
    - name: docker-py == 1.4.0
    - require:
      - pkg: python-pip-whl
      - pkg: pip-install
    - unless: pip list | grep docker-py
