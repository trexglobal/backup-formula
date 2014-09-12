#!/bin/bash

/usr/local/bin/backup perform --trigger {{ salt['grains.get']('id') }} --config-file=/root/Backup/config.rb
