ruby_pkgs:
  pkg.installed:
    - names:
      - ruby
      - ruby-dev
      - make
      - g++
      - s3cmd

backup:
  gem:
    - installed

/root/Backup:
  file.directory:
    - user: root
    - group: root
    - mode: 0755

/root/Backup/config.rb:
  file:
    - managed
    - user: root
    - group: root
    - mode: 440
    - source: salt://backup/files/config.rb
    - require:
      - file: /root/Backup


/root/Backup/models:
  file.directory:
    - user: root
    - group: root
    - mode: 0755
    - require:
      - file: /root/Backup

# Adding s3cmd config file
/root/.s3cfg:
  file:
    - managed
    - source: salt://php-apps/files/aws/s3cfg
    - user: root
    - group: root
    - mode: 0750
    - template: jinja
    - require:
      - pkg: s3cmd
