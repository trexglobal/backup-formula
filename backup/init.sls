ruby_pkgs:
  pkg.installed:
    - names:
      - ruby
      - ruby-dev
      - make
      - g++

backup:
  gem:
    - installed

/root/Backup:
  file.directory:
    - user: root
    - group: root
    - mode: 0755


/root/Backup/models:
  file.directory:
    - user: root
    - group: root
    - mode: 0755
    - require:
      - file: /root/Backup

/root/Backup/models/database.rb:
  file:
    - managed
    - template: jinja
    - user: root
    - group: root
    - mode: 440
    - source: salt://files/database.rb
    - require:
      - file: /root/Backup/models

# Simple script to run backup command
/usr/local/bin/run-backup:
  file:
    - managed
    - source: salt://files/run-backup
    - user: root
    - group: root
    - mode: 0777

/etc/cron.daily/00_database_backup_to_s3:
  file:
    - managed
    - user: root
    - group: root
    - mode: 755
    - source: salt://files/00_database_backup_to_s3
