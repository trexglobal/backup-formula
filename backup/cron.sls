# Add daily backup task
/etc/cron.daily/00_database_backup_to_s3:
  file:
    - managed
    - user: root
    - group: root
    - mode: 755
    - source: salt://backup/files/00_database_backup_to_s3
