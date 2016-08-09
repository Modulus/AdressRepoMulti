{% set app_dir = "/home/vagrant/nodeapp" %}



include:
  - git

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

dockerfile for nodeapp:
  file.managed:
    - source: salt://nodeapp/Dockerfile
    - name: {{app_dir}}/Dockerfile
    - require:
      - git: git clone https://github.com/Modulus/AdressRepoNode.git


pull node image:
  dockerng.image_present:
    - name: node

build nodeapp docker image:
  dockerng.image_present:
    - build: {{app_dir}}
    - name: nodeapp
    - force: True
    - require:
      - dockerng: pull node image
      - file: dockerfile for nodeapp

#TODO: Use saltmine to extract minion1 ip address
run nodeapp docker container:
  dockerng.running:
    - image: nodeapp
    - name: nodeapp
    - environment:
      - ENV: dev
    - port_bindings:
      - "3000:3000"
    - restart_policy: onfailure:5
    - require:
      - dockerng: build nodeapp docker image
    {% for server, addrs in salt["mine.get"]("roles:db", "network.ip_addrs", expr_form="grain").items() %}
    - extra_hosts:
      {% if server == "minion1" %}
      - db:{{addrs[0]}}
      {% else %}
      - {{server}}:{{addrs[0]}}
      {% endif %}
    {% endfor %}
