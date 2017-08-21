{% set tomcat_manager_user = 'saltuser1' %}
{% set tomcat_manager_pass = 'Blaat987' %}
{% set data_root = '/data' %}

tomcat:
  ver: 7
  java_opts:
    - 'Dxnat.home={{ data_root }}/xnat/home'
    - 'Xms512m'
    - 'Xmx1024m'
    - 'XX:MaxPermSize=256m'
  
  sites:
    xnat:
      name: xnat
      path: '/xnat'
      reloadable: "true"
      debug: 0

  manager:
    roles:
      - manager-gui
      - manager-script
      - manager-jmx
      - manager-status
    users:
      {{ tomcat_manager_user }}:
        passwd: {{ tomcat_manager_pass }}
        roles: manager-gui, manager-script, manager-jmx, manager-status
        
tomcat-manager:
  user: {{ tomcat_manager_user }}
  passwd: {{ tomcat_manager_pass }}

postgres:
  use_upstream_repo: true
  version: '9.6'

  users:
    xnat:
      ensure: present
      password: '9*Afb9yadf9by'
      createdb: False
      createroles: False

  databases:
    xnat:
      owner: 'xnat'

xnat:
  postgres_user: xnat
  postgres_pass: '9*Afb9yadf9by'
  conf_dir: {{ data_root }}/xnat/home/config
  directories:
    - {{ data_root }}/xnat/archive
    - {{ data_root }}/xnat/build
    - {{ data_root }}/xnat/cache
    - {{ data_root }}/xnat/ftp
    - {{ data_root }}/xnat/home/config
    - {{ data_root }}/xnat/home/logs
    - {{ data_root }}/xnat/home/plugins
    - {{ data_root }}/xnat/home/work
    - {{ data_root }}/xnat/pipeline
    - {{ data_root }}/xnat/prearchive
    - {{ data_root }}/xnat/archive

