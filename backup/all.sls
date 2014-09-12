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
    - makedirs: True

# Simple script to run backup command
/usr/local/bin/backup-all.sh:
  file:
    - managed
    - template: jinja
    - source: salt://backup/files/backup-all.sh
    - user: root
    - group: root
    - mode: 0777

# Add daily backup task
/etc/cron.daily/00_database_backup_to_s3:
  file:
    - managed
    - user: root
    - group: root
    - mode: 755
    - source: salt://backup/files/00_database_backup_to_s3
