#!/bin/sh

: "${DB_HOST:?DB_HOST is not set}"
: "${DB_PORT:?DB_PORT is not set}"
: "${DB_UNAME:?DB_UNAME is not set}"
: "${DB_NAME:?DB_NAME is not set}"
: "${DROPBOX_ACCESS_TOKEN:?DROPBOX_ACCESS_TOKEN is not set}"

pg_dumpall -h ${DB_HOST} -p ${DB_PORT} -U ${DB_UNAME} > /backups/db_backup.sql

curl -X POST https://content.dropboxapi.com/2/files/upload \
  --header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
  --header "Dropbox-API-Arg: {\"path\": \"/db_backup.sql\",\"mode\": \"overwrite\"}" \
  --header "Content-Type: application/octet-stream" \
  --data-binary @/backups/db_backup.sql

rm /backups/db_backup.sql