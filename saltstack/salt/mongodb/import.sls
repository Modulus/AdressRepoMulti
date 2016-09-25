include:
  - geo_files

saltutil.sync_all:
  module.run:
    - name: saltutil.sync_all


import data:
  module.run:
    - name: mongo.import_data
    - filepath: {{pillar["home"]}}countries/NO.txt
    - mongodb_url:  mongodb://localhost:27017
      

    - require:
      - module: saltutil.sync_all
      - archive: geonames extracted
