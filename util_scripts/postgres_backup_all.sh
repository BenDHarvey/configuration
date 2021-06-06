#!/bin/bash

PGPASSWORD=SuperSecret123!
PGUSERNAME=switchdin
PGPORT=5432
PGHOST=localhost
DB_NAME_STRING=postgresql://$PGUSERNAME:$PGPASSWORD@$PGHOST:$PGPORT

echo $DB_NAME_STRING

# Location to place backups.
BACKUPDIR="/home/ben/Workspace/db_dumps/backups/"
NIGHTLYDIR="/home/ben/Workspace/db_dumps/backups/latest/"

#String to append to the name of the backup files
BACKUPDATE=`date +%d-%m-%Y`
BACKUPDATE=$BACKUPDATE-$(date +%s)

#Numbers of days you want to keep copie of your databases
number_of_days=15

databases=`psql -h $PGHOST -p $PGPORT -U $PGUSERNAME -l -t  | cut -d'|' -f1 | sed -e 's/ //g' -e '/^$/d'`
for i in $databases; do  if [ "$i" != "postgres" ] && [ "$i" != "template0" ] && [ "$i" != "template1" ] && [ "$i" != "template_postgis" ]; then    
    echo Dumping $i to $BACKUPDIR$i-$BACKUPDATE.sql    

    docker run --rm --network=host -v "$BACKUPDIR:/tmp/dump" \
      postgres pg_dump -Fc -v --dbname="$DB_NAME_STRING/$i" -f "/tmp/dump/$i-$BACKUPDATE.sql" 

    bzip2 $BACKUPDIR$i-$BACKUPDATE.sql
    ln -fs $BACKUPDIR$i-$BACKUPDATE.sql.bz2 $NIGHTLYDIR$i-nightly.sql.bz2
  fi
done
find $backup_dir -type f -prune -mtime +$number_of_days -exec rm -f {} \;

