FROM alpine:latest

RUN apk add --no-cache postgresql-client curl tzdata

RUN cp /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
    echo "Asia/Kolkata" > /etc/timezone

RUN mkdir -p /backups

COPY backup.sh /usr/local/bin/backup.sh

RUN chmod +x /usr/local/bin/backup.sh

RUN echo "0 0 * * * /usr/local/bin/backup.sh" > /etc/crontabs/root

CMD ["crond", "-f"]
