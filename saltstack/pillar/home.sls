{% if grains["roles"] is iterable and "vagrant" in grains["roles"] or grains["roles"] is not iterable and grains["roles"] == "vagrant" %}
home: /home/vagrant/
app_dir: /home/vagrant/nodeapp
{% else %}
home: /home/ubuntu/
app_dir: /home/ubuntu/nodeapp
{% endif %}
