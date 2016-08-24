{%- set url = "http://download.geonames.org/export/zip/NO.zip" %}

include:
  - tools.curl
  - tools.unzip

download geodata:
  cmd.run:
      - name: curl -o codes.zip {{ url }}
      - cwd: /home/vagrant
      #- output_loglevel: quiet
      - require:
        - pkg: curl

download readme:
  cmd.run:
      - name: curl -O http://download.geonames.org/export/zip/readme.txt
      - cwd: /home/vagrant
      - require:
        - pkg: curl

geonames extracted:
  archive.extracted:
    - name: /home/vagrant/countries
    - source: /home/vagrant/codes.zip
    - archive_format: zip
    - require:
      - cmd: download geodata
