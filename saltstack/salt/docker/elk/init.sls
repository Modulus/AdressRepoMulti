elasticsearch image present:
  dockerng.image_present:
    - name: elasticsearch:latest

kibana image present:
  dockerng.image_present:
    - name: kibana:latest


docker run elasticsearch:
  dockerng.running:
    - image: elasticsearch
    - name: elasticsearch
    - port_bindings:
      - "9200:9200"
      - "9300:9300"
    - require:
      - dockerng: elasticsearch image present

docker run kibana:
  dockerng.running:
    - image: kibana
    - name: kibana
    - links:
      - elasticsearch:elasticsearch
    - require:
      - dockerng: kibana image present
      - dockerng: elasticsearch image present
