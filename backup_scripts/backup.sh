#!/bin/sh

: "${DB_HOST:?DB_HOST is not set}"
: "${DB_PORT:?DB_PORT is not set}"
: "${DB_UNAME:?DB_UNAME is not set}"
: "${DB_NAME:?DB_NAME is not set}"
: "${DROPBOX_ACCESS_TOKEN:?DROPBOX_ACCESS_TOKEN is not set}"

DATE=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="db_backup_${DATE}.sql"

export PGPASSWORD="${DB_PSWD}"

echo "Creating backup of $DB_NAME..."
pg_dump -h ${DB_HOST} -p ${DB_PORT} -U ${DB_UNAME} ${DB_NAME} > /backups/${BACKUP_FILE}

echo "Uploading backup to Dropbox..."
curl -X POST https://content.dropboxapi.com/2/files/upload \
  --header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
  --header "Dropbox-API-Arg: {\"path\": \"/${BACKUP_FILE}\",\"mode\": \"overwrite\"}" \
  --header "Content-Type: application/octet-stream" \
  --data-binary @/backups/${BACKUP_FILE}