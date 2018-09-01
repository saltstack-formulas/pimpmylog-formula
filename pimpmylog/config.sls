# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "pimpmylog/map.jinja" import pimpmylog with context %}


pimpmylog-config:
  file.serialize:
    - name: {{ pimpmylog.target }}/config.user.json
    - mode: 644
    - user: root
    - group: root
    - dataset: {{ pimpmylog.config }}
    - formatter: json
