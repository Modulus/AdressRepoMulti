include:
  - geo_files
  - sync

import data:
  module.run:
    - name: mongo.import_data
    - require:
      - module: sync_all
      - archive: geonames unzipped
