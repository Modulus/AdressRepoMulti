elasticsearch-py:
  pip.installed:
    - unless: pip freeze | grep 	elasticsearch-py
