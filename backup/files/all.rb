# encoding: utf-8

##
# Backup Generated: database
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t database [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#
Model.new('{{ salt['grains.get']('id') }}', 'Main backup on {{ salt['grains.get']('id') }}') do

  ##
  # Amazon Simple Storage Service [Storage]
  #
  store_with S3 do |s3|
    # AWS Credentials
    s3.access_key_id     = "{{ pillar['backup']['s3']['access_key_id'] }}"
    s3.secret_access_key = "{{ pillar['backup']['s3']['secret_access_key'] }}"

    s3.storage_class     = :reduced_redundancy
    s3.region            = "{{ pillar['backup']['s3']['region'] }}"
    s3.bucket            = "{{ pillar['backup']['s3']['bucket'] }}"
    s3.path              = "{{ pillar['backup']['s3']['path'] }}"
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.domain               = "{{ pillar['mail_alert']['account']['domain'] }}"
    mail.user_name            = "{{ pillar['mail_alert']['account']['email'] }}"
    mail.from                 = "{{ pillar['mail_alert']['account']['email'] }}"
    mail.to                   = "{{ pillar['mail_alert']['users'] | join(', ') }}"
    mail.address              = "{{ pillar['mail_alert']['account']['server'] }}"
    mail.port                 = "{{ pillar['mail_alert']['account']['port'] }}"
    mail.authentication       = "{{ pillar['mail_alert']['account']['authentication'] }}"
    mail.password             = "{{ pillar['mail_alert']['account']['password'] }}"
  end

  database MySQL do |db|
    db.name               = :all
    db.username           = "root"
    db.password           = "{{ pillar['mysql']['server']['root_password'] }}"
    db.host               = "localhost"
    db.port               = 3306
    db.additional_options = "--events --ignore-table=mysql.event"
  end

end
