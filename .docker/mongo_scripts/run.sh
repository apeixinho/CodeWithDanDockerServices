#!/bin/sh
# https://github.com/frodenas/docker-mongodb/blob/master/Dockerfile
# https://stackoverflow.com/questions/5725296/difference-between-sh-and-bash

# Initialize first run
if [[ -e /.firstrun ]]; then
    echo "Running entrypoint.sh"
    /mongo_scripts/entrypoint.sh
    
        
    echo "Scheduling backup CRON job for 13:00"
    #cat < crontab -l < echo "00 13 * * * /mongo_scripts/backup_job.sh" | crontab -
    echo "00 13 * * * /mongo_scripts/backup_job.sh" > crontab.tmp

    #echo '* */6 * * * /usr/bin/php /var/www/partkeepr/app/console partkeepr:cron:run' > crontab.tmp \
#     && echo '0 2   * * * /usr/bin/sql_backup' >> crontab.tmp \
#     && crontab crontab.tmp \
#     && rm -rf crontab.tmp


    echo "Scheduling backup CRON job for 1:00"
    #cat <(crontab -l) <(echo "00 01 * * * /mongo_scripts/backup_job.sh") | crontab -
    echo "00 01 * * * /mongo_scripts/backup_job.sh" >> crontab.tmp
    # * * * * * CRON job time to be executed
    # - - - - -
    # | | | | |
    # | | | | ----- Day of week (0 - 7) (Sunday=0 or 7)
    # | | | ------- Month (1 - 12)
    # | | --------- Day of month (1 - 31)
    # | ----------- Hour (0 - 23)
    # ------------- Minute (0 - 59)

    
    echo "Running first_run.sh"
    /mongo_scripts/first_run.sh
fi

# Start MongoDB
echo "Starting MongoDB..."
/usr/bin/mongod --auth $@