FROM mvertes/alpine-mongo

# Make sure necessary packages are installed
# RUN apt-get update && apt-get install -y cron netcat-traditional netcat-openbsd
RUN apk update && \
    apk upgrade && \
    apk add --no-cache netcat-openbsd

COPY ./.docker/mongo_scripts /mongo_scripts

# chmod details: http://www.computerhope.com/unix/uchmod.
# http://stackoverflow.com/questions/27281965/docker-file-chmod-on-entrypoint-script
RUN chmod +rx /mongo_scripts/*.sh
RUN touch /.firstrun

# RUN touch crontab.tmp \
#     && echo '* */6 * * * /usr/bin/php /var/www/partkeepr/app/console partkeepr:cron:run' > crontab.tmp \
#     && echo '0 2   * * * /usr/bin/sql_backup' >> crontab.tmp \
#     && crontab crontab.tmp \
#     && rm -rf crontab.tmp
#
# CMD [/usr/sbin/crond, -f, -d, 0]

EXPOSE 27017

ENTRYPOINT ["/mongo_scripts/run.sh"]


# To build:
# docker build -f mongo.dockerfile --tag $DOCKER_ACCT/mongo ../

# To run the image (add -d if you want it to run in the background)
# docker run -p 27017:27017 --env-file .docker/env/mongo.$APP_ENV.env -d --name mongo $DOCKER_ACCT/mongo
