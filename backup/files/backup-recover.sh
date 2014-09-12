#!/bin/bash

# !!!You have to install and setup s3cmd first!!!
# http://s3tools.org

# Download database and run migrations

# Without arguments you will get today db
# With argument you can controll for which date you want to download db
## e.g. 2013.01.10

tmp_folder=/tmp
project_name={{ pillar['app']['name'] }}
backup_s3_bucket={{ pillar['backup']['s3']['bucket'] }}
backup_s3_path={{ pillar['backup']['s3']['path'] }}
server_id={{ salt['grains.get']('id') }}

if [ "$#" == 0 ]
then
  selected_date=$(date +%Y.%m.%d);
else
  selected_date=$1
fi

cd "$tmp_folder"

echo "Removing previously downladed backup"
rm -rf "$server_id"

echo "Downloading backup data for ${selected_date}"
timestamp="${selected_date}*"
database_name="${project_name}_$(echo ${selected_date} | sed 's/\.//g')"

s3cmd get --skip-existing "s3://${backup_s3_bucket}/${backup_s3_path}/${server_id}/${timestamp}/${server_id}.tar"

selected_backup=$(ls -dt ${timestamp} | head -1)

echo "There were two backups, auto selecting ${selected_backup}"

echo "Unpacking backup data"
tar -xvf "${selected_backup}/all_database.tar"

echo "Creating database"
mysqladmin -f drop $database_name
mysqladmin create $database_name

echo "Loading data into database"
zcat ${server_id}/databases/MySQL.sql.gz | mysql $database_name

rm -rf "$server_id"

echo "Done"
