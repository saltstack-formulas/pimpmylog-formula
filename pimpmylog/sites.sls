# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "pimpmylog/map.jinja" import pimpmylog with context %}

pimpmylog_sites_config_dir:
  file.directory:
    - name: {{ pimpmylog.target }}/config.user.d
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

{% for k, v  in pimpmylog.sites.items() %}
pimpmylog_site_{{ k }}_config:
  {% if v.absent | default(false) %}
  file.absent:
    - name: {{ pimpmylog.target }}/config.user.d/{{ k }}.json
  {% else %}
  file.serialize:
    - name: {{ pimpmylog.target }}/config.user.d/{{ k }}.json
    - mode: 644
    - user: root
    - group: root
    - dataset: {{ v|yaml }}
    - formatter: json
    - require:
      - file: pimpmylog_sites_config_dir
  {% endif %}
{% endfor %}
