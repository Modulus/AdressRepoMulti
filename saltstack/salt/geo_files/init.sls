{%- set url = "http://download.geonames.org/export/zip/NO.zip" %}

include:
  - tools.curl
  - tools.unzip

download geodata:
  cmd.run:
      - name: curl -o codes.zip {{ url }}
      - cwd: {{pillar["home"]}}
      #- output_loglevel: quiet
      - require:
        - pkg: curl

download readme:
  cmd.run:
      - name: curl -O http://download.geonames.org/export/zip/readme.txt
      - cwd: {{pillar["home"]}}
      - require:
        - pkg: curl

geonames extracted:
  archive.extracted:
    - name: {{pillar["home"]}}countries
    - source: {{pillar["home"]}}codes.zip
    - archive_format: zip
    - require:
      - cmd: download geodata
