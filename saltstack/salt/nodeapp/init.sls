{% set app_dir = "/home/vagrant/nodeapp" %}

include:
  - git

set environement to dev:
  environ.setenv:
    - name: ENV
    - value: dev


manage file nodeapp.service:
  file.managed:
    - name: /etc/init/api.conf
    - source: salt://nodeapp/api.conf
    - require:
      - environ: set environement to dev


add database nodes to hosts:
  host.present:
   {% for hostname, addrs in salt["mine.get"]("roles:db", "network.ip_addrs", expr_form="grain").items() %}
   {% if hostname == "minion1" %}
    - name: db
   {% else %}
    - name: {{hostname}}
    {% endif %}
    - ip: {{addrs[0]}}
    {% endfor %}


git clone https://github.com/Modulus/AdressRepoNode.git:
  git.latest:
    - name: https://github.com/Modulus/AdressRepoNode.git
    - rev: master
    - branch: master
    - user: vagrant
    - target: {{app_dir}}
    - fetch_tags: True
    - force_reset: True
    - require:
      - pkg: git

npm install nodeapp:
  npm.bootstrap:
    - name: {{app_dir}}
    - require:
      - git: git clone https://github.com/Modulus/AdressRepoNode.git

enable nodeapp service:
  service.running:
    - name: api
    - enable: True
    - watch:
      - npm: npm install nodeapp
    - require:
      - file: manage file nodeapp.service
      - git: git clone https://github.com/Modulus/AdressRepoNode.git
