{% if pillar['backup'] is defined %}

# Install required packages
ruby_pkgs:
  pkg.installed:
    - names:
      - ruby
      - ruby-dev
      - make
      - g++
      - s3cmd

# Install backup gem
backup:
  gem:
    - installed

# Add generic backup configuration
/root/Backup/config.rb:
  file:
    - managed
    - user: root
    - group: root
    - mode: 440
    - source: salt://backup/files/config.rb
    - makedirs: True

# Adding s3cmd config file
/root/.s3cfg:
  file:
    - managed
    - source: salt://backup/files/s3cfg
    - user: root
    - group: root
    - mode: 0750
    - template: jinja
    - require:
      - pkg: s3cmd

{% for app in salt['pillar.get']('php_apps', []) %}

# Adding backup recover script
/usr/local/bin/backup-{{ app.name }}-recover.sh:
  file:
    - managed
    - source: salt://backup/files/backup-recover.sh
    - user: root
    - group: root
    - mode: 0755
    - template: jinja
    - require:
      - pkg: s3cmd
    - context:
        project_name: {{ app.name }}

{% endfor %}

{% endif %}
