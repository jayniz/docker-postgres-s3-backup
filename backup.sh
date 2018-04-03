#!/bin/bash
echo "`date` ~~~~~~~~~~~ STARTING BACKUP ~~~~~~~~~~~~"
rm -f /tmp/backup.sql.dump.bz2
# echo "Config:"
# echo "  - AWS_REGION=${AWS_REGION}"
# echo "  - AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
# echo "  - AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
# echo "  - AWS_BUCKET_NAME=${AWS_BUCKET_NAME}"
# echo "  - BACKUP_NAME=${BACKUP_NAME}"
# echo "  - PGHOST=${PGHOST}"
# echo "  - PGPORT=${PGPORT}"
# echo "  - PGUSER=${PGUSER}"
# echo "  - PGPASSWORD=${PGPASSWORD}"
echo "`date` Creating postgres dump"
${BACKUP_CMD:-pg_dumpall} | bzip2 > /tmp/backup.sql.dump.bz2
echo "`date` Uploading to S3"
/backup/s3upload.rb
echo "`date` Done!"
