{% if grains["roles"] is iterable and "vagrant" in grains["roles"] or grains["roles"] is not iterable and grains["roles"] == "vagrant" %}
user: vagrant
{% else %}
user: ubuntu
{% endif %}
