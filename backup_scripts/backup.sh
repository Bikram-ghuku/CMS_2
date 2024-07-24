#!bin/sh

apk add --no-cache postgresql-client curl

pg_dump -h ${DB_HOST} -p ${DB_PORT} -U ${DB_UNAME} ${DB_NAME} > /backups/db_backup.sql

curl -X POST https://content.dropboxapi.com/2/files/upload \
  --header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
  --header "Dropbox-API-Arg: {\"path\": \"/db_backup.sql\",\"mode\": \"overwrite\"}" \
  --header "Content-Type: application/octet-stream" \
  --data-binary @/backups/db_backup.sql