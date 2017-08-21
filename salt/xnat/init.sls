include:
  - tomcat
  - tomcat.config
  - tomcat.manager
  - postgres

{% set xnat_config_path = salt['file.join'](pillar['xnat']['conf_dir'], 'xnat-conf.properties') %}
xnat_config:
  file.managed:
    - name: {{ xnat_config_path }}
    - user: tomcat
    - group: tomcat
    - mode: 600
    - source: salt://xnat/templates/xnat-conf.properties.j2
    - template: jinja
    - defaults:
      xnat: {{ pillar['xnat'] }}
    - require:
      - xnat_data_directories


xnat_deploy:
  tomcat.war_deployed:
    - name: /xnat
    - war: salt://xnat/wars/xnat-1.7.3.1.war
    - require:
      - xnat_config
    
xnat_data_directories:
  file.directory:
    - user: tomcat
    - group: tomcat
    - mode: 750
    - makedirs: true
    - names: {{ pillar['xnat']['directories'] }}
