boto:
  pip.installed:
    - name: boto
    - unless: pip freeze | grep boto
