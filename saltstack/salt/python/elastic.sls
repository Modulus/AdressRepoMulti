elasticsearch:
  pip.installed:
    - unless: pip freeze | grep elasticsearch
