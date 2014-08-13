include:
  - backup

# Backup model for all mysql databases
/root/Backup/models/all.rb:
  file:
    - managed
    - template: jinja
    - user: root
    - group: root
    - mode: 440
    - source: salt://backup/files/all.rb
    - require:
      - file: /root/Backup/models

# Simple script to run backup command
/usr/local/bin/backup-all:
  file:
    - managed
    - template: jinja
    - source: salt://backup/files/backup-all
    - user: root
    - group: root
    - mode: 0777

/etc/cron.daily/00_database_backup_to_s3:
  file:
    - managed
    - user: root
    - group: root
    - mode: 755
    - source: salt://backup/files/00_database_backup_to_s3
