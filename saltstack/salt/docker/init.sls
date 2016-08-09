include:
  - python
  - python.docker



docker.dependencies:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Debian' %}
      - apt-transport-https
{% endif %}
      - ca-certificates

#For ubuntu 14.x LTS
docker.repository:
  pkgrepo.managed:
    - humanname: Docker Repository
{% if grains['os_family'] == 'RedHat' %}
    - baseurl: https://yum.dockerproject.org/repo/main/centos/$releasever/
    - gpgkey: https://yum.dockerproject.org/gpg
    - gpgcheck: 1
{% elif grains['os_family'] == 'Debian' %}
    - name: deb https://apt.dockerproject.org/repo ubuntu-trusty main
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
{% endif %}

# Remove old repo if it exists
docker.purge.lxc-docker:
  pkg.purged:
    - name: lxc-docker


docker.installed:
  pkg.installed:
    - pkgs:
      - docker-engine
    #- version: 1.10.0-0~trusty
    - require:
      - pkg: docker.dependencies
      - pkg: docker.purge.lxc-docker
      - pkgrepo: docker.repository

docker.service.start:
  service.running:
    - name: docker
    - enable: True
    - watch:
      - pkg: docker.installed
    - require:
      - pkg: docker.installed
