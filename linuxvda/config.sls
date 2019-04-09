# -*- coding: utf-8 -*-
# vim: ft: sls

{% from "linuxvda/map.jinja" import linuxvda with context %}

{%- set fqdn = salt['grains.get']('fqdn') %}
{%- if fqdn == salt['grains.get']('host') %}
  {%- set dn = salt['pillar.get']('linuxvda:domain') or None %}
  {%- if dn %}
    {%- set fqdn = fqdn ~ "." ~ dn %}
  {%- endif %}
{%- endif %}
  
include:
  - linuxvda.pkg

127.0.1.1:
  host.only:
    - hostnames:
      - {{ fqdn }}
      - {{ salt['grains.get']('host') }}
      {% if linuxvda.fqdn_resolver_alias %}
      - {{ linuxvda.fqdn_resolver_alias }}
      {% endif %}

  {% for config in linuxvda.nsswitch.regex %}
linuxvda_nsswitch_{{ config[0] }}:
  file.replace:
    - name: /etc/nsswitch.conf
    - pattern: {{ config[1] }}
    - repl: {{ config[2] }}
    - backup: '.salt.bak'
    - require:
      - pkg: linuxvda_package
    - require_in:
      - file: linuxvda_config_setup
  {% endfor %}

{%- if linuxvda.cleanup_before_setup %}
linuxvda_config_presetup:
  cmd.run:
    - name: {{ linuxvda.citrix.ctxcleanup }}
    - onlyif: test -f {{ linuxvda.citrix.ctxcleanup }}
    - require_in:
      - file: linuxvda_config_setup 
{%- endif %}

linuxvda_config_setup:
  file.managed:
    - name: {{ linuxvda.dl.tmpdir }}/vdasetup.sh
    - source: salt://linuxvda/files/vdasetup.sh
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - template: jinja
    - context:
      ctxsetup: {{ linuxvda.citrix.ctxsetup }}
      CTX_XDL_SITE_NAME: {{ linuxvda.citrix.variables.CTX_XDL_SITE_NAME }}
      CTX_XDL_LDAP_LIST: {{ linuxvda.citrix.variables.CTX_XDL_LDAP_LIST }}
      CTX_XDL_SEARCH_BASE: {{ linuxvda.citrix.variables.CTX_XDL_SEARCH_BASE }}
      CTX_XDL_DDC_LIST: {{ linuxvda.citrix.variables.CTX_XDL_DDC_LIST }}
      CTX_XDL_SUPPORT_DDC_AS_CNAME: {{ linuxvda.citrix.variables.CTX_XDL_SUPPORT_DDC_AS_CNAME }}
      CTX_XDL_VDA_PORT: {{ linuxvda.citrix.variables.CTX_XDL_VDA_PORT }}
      CTX_XDL_REGISTER_SERVICE: {{ linuxvda.citrix.variables.CTX_XDL_REGISTER_SERVICE }}
      CTX_XDL_ADD_FIREWALL_RULES: {{ linuxvda.citrix.variables.CTX_XDL_ADD_FIREWALL_RULES }}
      CTX_XDL_AD_INTEGRATION: {{ linuxvda.citrix.variables.CTX_XDL_AD_INTEGRATION }}
      CTX_XDL_HDX_3D_PRO: {{ linuxvda.citrix.variables.CTX_XDL_HDX_3D_PRO }}
      CTX_XDL_VDI_MODE: {{ linuxvda.citrix.variables.CTX_XDL_VDI_MODE }}
      CTX_XDL_START_SERVICE: {{ linuxvda.citrix.variables.CTX_XDL_START_SERVICE }}
      CTX_XDL_FAS_LIST: {{ linuxvda.citrix.variables.CTX_XDL_FAS_LIST }}
  cmd.run:
    - name: {{ linuxvda.dl.tmpdir }}/vdasetup.sh
    - require:
      - file: {{ linuxvda.dl.tmpdir }}/vdasetup.sh
    - cwd: /

  {%- for svc in linuxvda.services %}
linuxvda_{{ svc }}_running:
  service.running:
    - name: {{ svc }}
    - enable: True
  {% endfor %}

