Backup SaltStack Formula
=============

Setup backup for all databases on the server using https://meskyanichi.github.io/backup/v4/

## What it does

1. backup
1.1. Install ruby and ruby-dev dependencies
1.2. Install backup gem
2. backup.all
2.1. Add backup model for all databases
2.2. Add backup to daily tasks

## Install

1. Setup [pillar](http://docs.saltstack.com/en/latest/topics/pillar/) from pillar.example
2. Add backup to your server [state file](http://docs.saltstack.com/en/latest/topics/tutorials/starting_states.html)

  ```yaml
  include:
      - backup.all
  ```

  or to the [top.sls](http://docs.saltstack.com/en/latest/ref/states/top.html) file

  ```yaml
  base:
    'some.server.example.com':
      - backup.all
  ```
