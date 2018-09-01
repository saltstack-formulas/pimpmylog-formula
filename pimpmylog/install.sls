# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "pimpmylog/map.jinja" import pimpmylog with context %}

pimpmylog_git_install:
  git.latest:
    - name: {{ pimpmylog.url }}
    - user: {{ pimpmylog.user }}
    - branch: {{ pimpmylog.branch | default('master') }}
    - rev: {{ pimpmylog.branch | default('master') }}
    - target: {{ pimpmylog.target }}

pimpmylog_conf_user_d:
  file.directory:
    - name: {{ pimpmylog.target }}/conf.user.d
    - makedirs: true
    - require:
      - git: pimpmylog_git_install

